PREFIX=uniform/EBS_01_Subway_S2T1_out
PREFIX1=EBS_Video_2
SRC=../PlenopticServer1/Diff/$PREFIX
DST=../PlenopticServer2/2023-EBS/GRID49_GS_VIDEO_FINE/$PREFIX

mkdir -p $DST

#python train.py -s data/scview/EBS2 --port 6017 --expname "scview/EBS_Video_2" --configs arguments/scview/Sample.py --save_iterations 30000 60000 90000 120000 150000 180000 200000
#python render.py --model_path "output/scview/EBS_Video_2" --skip_train --focal 80.0
    
SET1=$(seq 0 1 9)
for i in $SET1
do
    grid_generation/grid_generation output/scview/$PREFIX1/video_00$i/ours_200000/renders 960 540 $DST/$i
done

SET1=$(seq 10 1 99)
for i in $SET1
do
    grid_generation/grid_generation output/scview/$PREFIX1/video_0$i/ours_200000/renders 960 540 $DST/$i
done


PREFIX1=EBS_Video_3

#python train.py -s data/scview/EBS3 --port 6017 --expname "scview/EBS_Video_3" --configs arguments/scview/Sample.py --save_iterations 30000 60000 90000 120000 150000 180000 200000 --checkpoint_iterations 30000 60000 90000 120000 150000 180000 200000
#python render.py --model_path "output/scview/EBS_Video_3" --skip_train --focal 80.0
    
SET1=$(seq 0 1 9)
for i in $SET1
do
    grid_generation/grid_generation output/scview/$PREFIX1/video_00$i/ours_200000/renders 960 540 $DST/$i
done

SET1=$(seq 10 1 99)
for i in $SET1
do
    grid_generation/grid_generation output/scview/$PREFIX1/video_0$i/ours_200000/renders 960 540 $DST/$i
done


SET1=$(seq 100 1 1068)
for i in $SET1
do
    grid_generation/grid_generation output/scview/$PREFIX1/video_$i/ours_200000/renders 960 540 $DST/$i
done
