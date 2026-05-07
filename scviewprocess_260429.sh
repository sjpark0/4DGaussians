workdir=$1

SET=$(seq 1 1 9)
for num in $SET
do
    cp $workdir/cam0$num/frame_00001.jpg ./colmap_tmp/images/image$num.jpg
done
SET=$(seq 10 1 16)
for num in $SET
do
    cp $workdir/cam$num/frame_00001.jpg ./colmap_tmp/images/image$num.jpg
done

colmap image_undistorter --image_path ./colmap_tmp/images --input_path ./colmap_tmp/sparse/0 --output_path ./colmap_tmp/dense --output_type COLMAP
colmap patch_match_stereo --workspace_path ./colmap_tmp/dense --workspace_format COLMAP --PatchMatchStereo.geom_consistency true
colmap stereo_fusion --workspace_path ./colmap_tmp/dense --workspace_format COLMAP --input_type geometric --output_path ./colmap_tmp/dense/fused.ply

python scripts/downsample_point.py ./colmap_tmp/dense/fused.ply $workdir/points3D_scview.ply


#rm -rf ./colmap_tmp
#rm -rf ./LLFF



