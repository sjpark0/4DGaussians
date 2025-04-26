set workdir1=VideoSample
set workdir=data\multiview\%workdir1%
set /a i=0
:loop
set /a j=i
set /a i+=1
mkdir %workdir%\out\cam0%i%
ffmpeg -i %workdir%\00%j%.mp4 -vf fps=30 %workdir%\out\cam0%i%\frame_%%5d.jpg
if %i% leq 8 goto loop

mkdir %workdir%\out\cam10
ffmpeg -i %workdir%\009.mp4 -vf fps=30 %workdir%\out\cam10\frame_%%5d.jpg


:loop1
set /a j=i
set /a i+=1
mkdir %workdir%\out\cam%i%
ffmpeg -i %workdir%\0%j%.mp4 -vf fps=30 %workdir%\out\cam%i%\frame_%%5d.jpg
if %i% leq 15 goto loop1

python scripts\extractimages.py multiview\%workdir1%\out

colmap feature_extractor --database_path ./colmap_tmp/database.db --image_path ./colmap_tmp/images  --SiftExtraction.max_image_size 4096 --SiftExtraction.max_num_features 16384 --SiftExtraction.estimate_affine_shape 1 --SiftExtraction.domain_size_pooling 1
colmap exhaustive_matcher --database_path ./colmap_tmp/database.db
mkdir colmap_tmp\sparse
colmap mapper --database_path ./colmap_tmp/database.db --image_path ./colmap_tmp/images --output_path ./colmap_tmp/sparse
mkdir %workdir%\out\sparse_
copy colmap_tmp\sparse\0\* %workdir%\out\sparse_

mkdir colmap_tmp\dense
colmap image_undistorter --image_path ./colmap_tmp/images --input_path ./colmap_tmp/sparse/0 --output_path ./colmap_tmp/dense --output_type COLMAP
colmap patch_match_stereo --workspace_path ./colmap_tmp/dense --workspace_format COLMAP --PatchMatchStereo.geom_consistency true
colmap stereo_fusion --workspace_path ./colmap_tmp/dense --workspace_format COLMAP --input_type geometric --output_path ./colmap_tmp/dense/fused.ply

python scripts/downsample_point.py ./colmap_tmp/dense/fused.ply %workdir%/out/points3D_multipleview.ply

python imgs2poses.py ./colmap_tmp/

copy .\colmap_tmp\poses_bounds.npy %workdir%\out\poses_bounds_multipleview.npy

del ./colmap_tmp
rmdir ./colmap_tmp