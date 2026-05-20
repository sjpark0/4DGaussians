#
# Copyright (C) 2023, Inria
# GRAPHDECO research group, https://team.inria.fr/graphdeco
# All rights reserved.
#
# This software is free for non-commercial, research and evaluation use
# under the terms of the LICENSE.md file.
#
# For inquiries contact george.drettakis@inria.fr
#

import torch
from torch import nn

from scene.gaussian_model import GaussianModel
from utils.general_utils import get_expon_lr_func


class GaussianModelDeformationOnly(GaussianModel):
    """Gaussian model variant that keeps loaded Gaussians fixed.

    Use this model when a previous chunk's Gaussian PLY should be reused as a
    frozen canonical point set and only the deformation network/grid should be
    optimized for the next frames.
    """

    _STATIC_GAUSSIAN_ATTRS = (
        "_xyz",
        "_features_dc",
        "_features_rest",
        "_scaling",
        "_rotation",
        "_opacity",
    )

    def __init__(self, sh_degree: int, args):
        super().__init__(sh_degree, args)
        self._static_mutation_warnings = set()
        print("deformation only")

    def _freeze_static_gaussians(self):
        for attr_name in self._STATIC_GAUSSIAN_ATTRS:
            tensor = getattr(self, attr_name, None)
            if isinstance(tensor, nn.Parameter):
                tensor.requires_grad_(False)
            elif torch.is_tensor(tensor) and tensor.numel() > 0:
                setattr(self, attr_name, nn.Parameter(tensor.detach(), requires_grad=False))

    def _enable_deformation_gradients(self):
        self._deformation = self._deformation.to("cuda")
        for parameter in self._deformation.parameters():
            parameter.requires_grad_(True)

    def _warn_static_mutation_disabled(self, operation_name):
        if operation_name not in self._static_mutation_warnings:
            print(
                f"[deformation-only] {operation_name} skipped: "
                "loaded Gaussian PLY tensors are frozen."
            )
            self._static_mutation_warnings.add(operation_name)

    def create_from_pcd(self, pcd, spatial_lr_scale: float, time_line: int):
        super().create_from_pcd(pcd, spatial_lr_scale, time_line)
        self._freeze_static_gaussians()
        self._enable_deformation_gradients()

    def create_from_previous_ply(self, ply_path: str, spatial_lr_scale: float, time_line: int):
        super().create_from_previous_ply(ply_path, spatial_lr_scale, time_line)
        self._freeze_static_gaussians()
        self._enable_deformation_gradients()
        print(
            "[deformation-only] Previous Gaussian PLY loaded as frozen static state; "
            "optimizer will train deformation/grid parameters only."
        )

    def load_ply(self, path):
        super().load_ply(path)
        self._freeze_static_gaussians()

    def restore(self, model_args, training_args):
        (
            self.active_sh_degree,
            self._xyz,
            deform_state,
            self._deformation_table,
            self._features_dc,
            self._features_rest,
            self._scaling,
            self._rotation,
            self._opacity,
            self.max_radii2D,
            xyz_gradient_accum,
            denom,
            opt_dict,
            self.spatial_lr_scale,
        ) = model_args

        self._deformation.load_state_dict(deform_state)
        self._freeze_static_gaussians()
        self.training_setup(training_args)
        self.xyz_gradient_accum = xyz_gradient_accum
        self.denom = denom

        try:
            self.optimizer.load_state_dict(opt_dict)
        except ValueError as exc:
            print(
                "[deformation-only] Optimizer state was not restored because it "
                f"does not match deformation-only parameter groups: {exc}"
            )

    def training_setup(self, training_args):
        self.percent_dense = training_args.percent_dense
        self._freeze_static_gaussians()
        self._enable_deformation_gradients()

        self.xyz_gradient_accum = torch.zeros((self.get_xyz.shape[0], 1), device="cuda")
        self.denom = torch.zeros((self.get_xyz.shape[0], 1), device="cuda")
        self._deformation_accum = torch.zeros((self.get_xyz.shape[0], 3), device="cuda")

        deformation_params = [
            parameter
            for parameter in self._deformation.get_mlp_parameters()
            if parameter.requires_grad
        ]
        grid_params = [
            parameter
            for parameter in self._deformation.get_grid_parameters()
            if parameter.requires_grad
        ]

        optimizer_groups = []
        if deformation_params:
            optimizer_groups.append(
                {
                    "params": deformation_params,
                    "lr": training_args.deformation_lr_init * self.spatial_lr_scale,
                    "name": "deformation",
                }
            )
        if grid_params:
            optimizer_groups.append(
                {
                    "params": grid_params,
                    "lr": training_args.grid_lr_init * self.spatial_lr_scale,
                    "name": "grid",
                }
            )

        if not optimizer_groups:
            raise RuntimeError("No deformation parameters are available for training.")

        self.optimizer = torch.optim.Adam(optimizer_groups, lr=0.0, eps=1e-8)
        self.xyz_scheduler_args = lambda iteration: 0.0
        self.deformation_scheduler_args = get_expon_lr_func(
            lr_init=training_args.deformation_lr_init * self.spatial_lr_scale,
            lr_final=training_args.deformation_lr_final * self.spatial_lr_scale,
            lr_delay_mult=training_args.deformation_lr_delay_mult,
            max_steps=training_args.position_lr_max_steps,
        )
        self.grid_scheduler_args = get_expon_lr_func(
            lr_init=training_args.grid_lr_init * self.spatial_lr_scale,
            lr_final=training_args.grid_lr_final * self.spatial_lr_scale,
            lr_delay_mult=training_args.deformation_lr_delay_mult,
            max_steps=training_args.position_lr_max_steps,
        )

    def update_learning_rate(self, iteration):
        for param_group in self.optimizer.param_groups:
            if "grid" in param_group["name"]:
                param_group["lr"] = self.grid_scheduler_args(iteration)
            elif param_group["name"] == "deformation":
                param_group["lr"] = self.deformation_scheduler_args(iteration)

    def reset_opacity(self):
        self._warn_static_mutation_disabled("reset_opacity")

    def replace_tensor_to_optimizer(self, tensor, name):
        self._warn_static_mutation_disabled(f"replace_tensor_to_optimizer({name})")
        return {}

    def _prune_optimizer(self, mask):
        self._warn_static_mutation_disabled("_prune_optimizer")
        return {}

    def prune_points(self, mask):
        self._warn_static_mutation_disabled("prune_points")

    def cat_tensors_to_optimizer(self, tensors_dict):
        self._warn_static_mutation_disabled("cat_tensors_to_optimizer")
        return {}

    def densification_postfix(
        self,
        new_xyz,
        new_features_dc,
        new_features_rest,
        new_opacities,
        new_scaling,
        new_rotation,
        new_deformation_table,
    ):
        self._warn_static_mutation_disabled("densification_postfix")

    def densify_and_split(self, grads, grad_threshold, scene_extent, N=2):
        self._warn_static_mutation_disabled("densify_and_split")

    def densify_and_clone(
        self,
        grads,
        grad_threshold,
        scene_extent,
        density_threshold=20,
        displacement_scale=20,
        model_path=None,
        iteration=None,
        stage=None,
    ):
        self._warn_static_mutation_disabled("densify_and_clone")

    def add_point_by_mask(self, selected_pts_mask, perturb=0):
        self._warn_static_mutation_disabled("add_point_by_mask")
        return None, None

    def prune(self, max_grad, min_opacity, extent, max_screen_size):
        self._warn_static_mutation_disabled("prune")

    def densify(
        self,
        max_grad,
        min_opacity,
        extent,
        max_screen_size,
        density_threshold,
        displacement_scale,
        model_path=None,
        iteration=None,
        stage=None,
    ):
        self._warn_static_mutation_disabled("densify")

    def grow(self, *args, **kwargs):
        self._warn_static_mutation_disabled("grow")
