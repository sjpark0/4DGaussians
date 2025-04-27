set workdir=data\scview\Sample2

colmap feature_extractor --database_path %workdir%\database.db --image_path %workdir%\images  --SiftExtraction.max_image_size 4096 --SiftExtraction.max_num_features 16384 --SiftExtraction.estimate_affine_shape 1 --SiftExtraction.domain_size_pooling 1
colmap exhaustive_matcher --database_path %workdir%\database.db
mkdir %workdir%\sparse
colmap mapper --database_path %workdir%\database.db --image_path %workdir%\images --output_path %workdir%\sparse

mkdir %workdir%\dense
colmap image_undistorter --image_path %workdir%\images --input_path %workdir%\sparse\0 --output_path %workdir%\dense --output_type COLMAP
colmap patch_match_stereo --workspace_path %workdir%\dense --workspace_format COLMAP --PatchMatchStereo.geom_consistency true
colmap stereo_fusion --workspace_path %workdir%\dense --workspace_format COLMAP --input_type geometric --output_path %workdir%\dense\fused.ply

python scripts/downsample_point.py %workdir%\dense\fused.ply %workdir%\points3D_scview.ply

python imgs2poses.py %workdir%

copy %workdir%\poses_bounds.npy %workdir%\poses_bounds_scview.npy
