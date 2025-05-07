

workdir=$1
datatype=$2 # blender, hypernerf, llff
export CUDA_VISIBLE_DEVICES=0

colmap feature_extractor --database_path $workdir/colmap/database.db --image_path $workdir/colmap/images  --SiftExtraction.max_image_size 4096 --SiftExtraction.max_num_features 16384 --SiftExtraction.estimate_affine_shape 1 --SiftExtraction.domain_size_pooling 1
colmap exhaustive_matcher --database_path $workdir/colmap/database.db
mkdir $workdir/colmap/sparse
colmap mapper --database_path $workdir/colmap/database.db --image_path $workdir/colmap/images --output_path $workdir/colmap/sparse

mkdir $workdir/colmap/dense
colmap image_undistorter --image_path $workdir/colmap/images --input_path $workdir/colmap/sparse/0 --output_path $workdir/colmap/dense --output_type COLMAP
colmap patch_match_stereo --workspace_path $workdir/colmap/dense --workspace_format COLMAP --PatchMatchStereo.geom_consistency true
colmap stereo_fusion --workspace_path $workdir/colmap/dense --workspace_format COLMAP --input_type geometric --output_path $workdir/colmap/dense/fused.ply

python scripts/downsample_point.py $workdir/colmap/dense/fused.ply $workdir/points3D_downsample2.ply

python imgs2poses.py $workdir/colmap/

cp $workdir/colmap/poses_bounds.npy $workdir/poses_bounds1.npy