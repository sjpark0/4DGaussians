DST1=./PlenopticServer2/2023-EBS/GRID_2026/GRID49_GS_VIDEO_100_30000_New3/$PREFIX
DST2=./PlenopticServer2/2023-EBS/GRID_2026/GRID49_GS_VIDEO_100_50000_New3/$PREFIX

mkdir -p $DST1
mkdir -p $DST2

#rm -rf colmap_tmp
#sh scviewprocess_250722.sh ./data/EBS/Test2/EBS3_2

SET=$(seq 6 1 9)
for num in $SET
do
    SRC=./data/EBS/Test2/EBS3_$num
    cp -r ./data/EBS/Test2/EBS3_2/sparse_ $SRC/sparse_
    cp ./data/EBS/Test2/EBS3_2/points3D_scview.ply $SRC
    cp ./data/EBS/Test2/EBS3_2/poses_bounds_scview.npy $SRC
    
    python train.py -s $SRC --port 600$num --expname "scview/EBS_Video_8/$num" --configs arguments/scview/default.py --save_iterations 30000 50000 --checkpoint_iterations 30000 50000 --deformation_only
    python render.py --model_path "output/scview/EBS_Video_8/$num" --skip_train --focal 80 --iteration 30000
    #python grid_generation.py $SRC ./output/scview/EBS_Video_8/$num 30000 $DST1 20
    SET1=$(seq 0 1 9)
    for i in $SET1
    do
        grid_generation/grid_generation output/scview/EBS_Video_8/$num/video_00$i/ours_30000/renders 960 540 $DST1/$((num * 100 + i))
    done

    SET1=$(seq 10 1 99)
    for i in $SET1
    do
        grid_generation/grid_generation output/scview/EBS_Video_8/$num/video_0$i/ours_30000/renders 960 540 $DST1/$((num * 100 + i))
        
    done

    python render.py --model_path "output/scview/EBS_Video_8/$num" --skip_train --focal 80 --iteration 50000
    #python grid_generation.py $SRC ./output/scview/EBS_Video_8/$num 50000 $DST2 20
    SET1=$(seq 0 1 9)
    for i in $SET1
    do
        grid_generation/grid_generation output/scview/EBS_Video_8/$num/video_00$i/ours_50000/renders 960 540 $DST2/$((num * 100 + i))
    done

    SET1=$(seq 10 1 99)
    for i in $SET1
    do
        grid_generation/grid_generation output/scview/EBS_Video_8/$num/video_0$i/ours_50000/renders 960 540 $DST2/$((num * 100 + i))
        
    done

    python export_perframe_3DGS.py --iteration 50000 --configs arguments/scview/default.py --model_path output/scview/EBS_Video_8/$num
    cp output/scview/EBS_Video_8/$num/gaussian_pertimestamp/last.ply ./data/EBS/Test2/EBS3_$((num + 1))
done
