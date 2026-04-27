workdir=$1
python scripts/extractimages_scview.py $workdir

mkdir $workdir/sparse_
cp -r ./colmap_tmp/sparse/0/* $workdir/sparse_
colmap image_undistorter --image_path ./colmap_tmp/images --input_path ./colmap_tmp/sparse/0 --output_path ./colmap_tmp/dense --output_type COLMAP
colmap patch_match_stereo --workspace_path ./colmap_tmp/dense --workspace_format COLMAP --PatchMatchStereo.geom_consistency true
colmap stereo_fusion --workspace_path ./colmap_tmp/dense --workspace_format COLMAP --input_type geometric --output_path ./colmap_tmp/dense/fused.ply

python scripts/downsample_point.py ./colmap_tmp/dense/fused.ply $workdir/points3D_scview.ply

python imgs2poses.py ./colmap_tmp/

cp ./colmap_tmp/poses_bounds.npy $workdir/poses_bounds_scview.npy

#rm -rf ./colmap_tmp
#rm -rf ./LLFF



