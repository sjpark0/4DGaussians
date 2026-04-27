PREFIX=uniform/EBS_01_Subway_S2T1_out
DST=../PlenopticServer2/2023-EBS/GRID49_GS_VIDEO/$PREFIX
mkdir -p $DST

python render.py --model_path output/scview/EBS_Video_1/ --skip_train --focal 80.0
SET1=$(seq 0 1 9)
for i in $SET1
do
    grid_generation/grid_generation output/scview/EBS_Video_1/video_00$i/ours_14000/renders 960 540 $DST/$i
done

SET1=$(seq 10 1 99)
for i in $SET1
do
    grid_generation/grid_generation output/scview/EBS_Video_1/video_0$i/ours_14000/renders 960 540 $DST/$i
done
