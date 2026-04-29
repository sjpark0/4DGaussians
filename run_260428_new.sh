DST1=./PlenopticServer2/2023-EBS/GRID_2026/GRID49_GS_VIDEO_100_30000_New/$PREFIX
DST2=./PlenopticServer2/2023-EBS/GRID_2026/GRID49_GS_VIDEO_100_50000_New/$PREFIX

#mkdir -p $DST1
#mkdir -p $DST2

#python copy_260428.py
#sh scviewprocess_250722.sh $SRC
#rm -rf colmap_tmp
#sh scviewprocess_250722.sh ./data/scview/EBS3_0

python export_perframe_3DGS.py --iteration 50000 --configs arguments/scview/default.py --model_path output/scview/EBS_Video_4/4
cp output/scview/EBS_Video_4/4/gaussian_pertimestamp/last.ply ./data/scview/EBS3_5

SET=$(seq 5 1 10)
for num in $SET
do
    SRC=./data/scview/EBS3_$num
    
    #python train.py -s $SRC --port 600$num --expname "scview/EBS_Video_4/$num" --configs arguments/scview/default.py --save_iterations 30000 50000 --checkpoint_iterations 30000 50000
    python render.py --model_path "output/scview/EBS_Video_4/$num" --skip_train --focal 80 --iteration 30000

    SET1=$(seq 0 1 9)
    for i in $SET1
    do
        grid_generation/grid_generation output/scview/EBS_Video_4/$num/video_00$i/ours_30000/renders 960 540 $DST1/$((num * 100 + i))
    done

    SET1=$(seq 10 1 99)
    for i in $SET1
    do
        grid_generation/grid_generation output/scview/EBS_Video_4/$num/video_0$i/ours_30000/renders 960 540 $DST1/$((num * 100 + i))
        
    done

    python render.py --model_path "output/scview/EBS_Video_4/$num" --skip_train --focal 80 --iteration 50000


    SET1=$(seq 0 1 9)
    for i in $SET1
    do
        grid_generation/grid_generation output/scview/EBS_Video_4/$num/video_00$i/ours_50000/renders 960 540 $DST2/$((num * 100 + i))
    done

    SET1=$(seq 10 1 99)
    for i in $SET1
    do
        grid_generation/grid_generation output/scview/EBS_Video_4/$num/video_0$i/ours_50000/renders 960 540 $DST2/$((num * 100 + i))
        
    done

    python export_perframe_3DGS.py --iteration 50000 --configs arguments/scview/default.py --model_path output/scview/EBS_Video_4/$num
    cp output/scview/EBS_Video_4/$num/gaussian_pertimestamp/last.ply ./data/scview/EBS3_$((num + 1))
done
