PREFIX=uniform/EBS_01_Subway_S2T1_out
PREFIX1=EBS_Video_2
SRC=../PlenopticServer1/Diff/$PREFIX
#DST=../PlenopticServer2/2023-EBS/GRID49_GS_VIDEO_FINE/$PREFIX
DST1=../PlenopticServer2/2023-EBS/GRID49_GS_VIDEO_FINE_30000/$PREFIX
DST2=../PlenopticServer2/2023-EBS/GRID49_GS_VIDEO_FINE_60000/$PREFIX
DST3=../PlenopticServer2/2023-EBS/GRID49_GS_VIDEO_FINE_90000/$PREFIX
DST4=../PlenopticServer2/2023-EBS/GRID49_GS_VIDEO_FINE_120000/$PREFIX
DST5=../PlenopticServer2/2023-EBS/GRID49_GS_VIDEO_FINE_150000/$PREFIX
DST6=../PlenopticServer2/2023-EBS/GRID49_GS_VIDEO_FINE_180000/$PREFIX

mkdir -p $DST1
mkdir -p $DST2
mkdir -p $DST3
mkdir -p $DST4
mkdir -p $DST5
mkdir -p $DST6


PREFIX1=EBS_Video_3

#python train.py -s data/scview/EBS3 --port 6017 --expname "scview/EBS_Video_3" --configs arguments/scview/Sample.py --save_iterations 30000 60000 90000 120000 150000 180000 200000 --checkpoint_iterations 30000 60000 90000 120000 150000 180000 200000
python render.py --model_path "output/scview/EBS_Video_3" --skip_train --focal 80.0 --iteration 30000
python render.py --model_path "output/scview/EBS_Video_3" --skip_train --focal 80.0 --iteration 60000
python render.py --model_path "output/scview/EBS_Video_3" --skip_train --focal 80.0 --iteration 90000
python render.py --model_path "output/scview/EBS_Video_3" --skip_train --focal 80.0 --iteration 120000
python render.py --model_path "output/scview/EBS_Video_3" --skip_train --focal 80.0 --iteration 150000
python render.py --model_path "output/scview/EBS_Video_3" --skip_train --focal 80.0 --iteration 180000

OFFSET=503
SET1=$(seq 0 1 9)
for i in $SET1
do
    grid_generation/grid_generation output/scview/$PREFIX1/video_00$i/ours_30000/renders 960 540 $DST1/$((OFFSET + i))
    grid_generation/grid_generation output/scview/$PREFIX1/video_00$i/ours_60000/renders 960 540 $DST2/$((OFFSET + i))
    grid_generation/grid_generation output/scview/$PREFIX1/video_00$i/ours_90000/renders 960 540 $DST3/$((OFFSET + i))
    grid_generation/grid_generation output/scview/$PREFIX1/video_00$i/ours_120000/renders 960 540 $DST4/$((OFFSET + i))
    grid_generation/grid_generation output/scview/$PREFIX1/video_00$i/ours_150000/renders 960 540 $DST5/$((OFFSET + i))
    grid_generation/grid_generation output/scview/$PREFIX1/video_00$i/ours_180000/renders 960 540 $DST6/$((OFFSET + i))

done

SET1=$(seq 10 1 99)
for i in $SET1
do
    grid_generation/grid_generation output/scview/$PREFIX1/video_0$i/ours_30000/renders 960 540 $DST1/$((OFFSET + i))
    grid_generation/grid_generation output/scview/$PREFIX1/video_0$i/ours_60000/renders 960 540 $DST2/$((OFFSET + i))
    grid_generation/grid_generation output/scview/$PREFIX1/video_0$i/ours_90000/renders 960 540 $DST3/$((OFFSET + i))
    grid_generation/grid_generation output/scview/$PREFIX1/video_0$i/ours_120000/renders 960 540 $DST4/$((OFFSET + i))
    grid_generation/grid_generation output/scview/$PREFIX1/video_0$i/ours_150000/renders 960 540 $DST5/$((OFFSET + i))
    grid_generation/grid_generation output/scview/$PREFIX1/video_0$i/ours_180000/renders 960 540 $DST6/$((OFFSET + i))
    
done


SET1=$(seq 100 1 1068)
for i in $SET1
do
    grid_generation/grid_generation output/scview/$PREFIX1/video_$i/ours_30000/renders 960 540 $DST1/$((OFFSET + i))
    grid_generation/grid_generation output/scview/$PREFIX1/video_$i/ours_60000/renders 960 540 $DST2/$((OFFSET + i))
    grid_generation/grid_generation output/scview/$PREFIX1/video_$i/ours_90000/renders 960 540 $DST3/$((OFFSET + i))
    grid_generation/grid_generation output/scview/$PREFIX1/video_$i/ours_120000/renders 960 540 $DST4/$((OFFSET + i))
    grid_generation/grid_generation output/scview/$PREFIX1/video_$i/ours_150000/renders 960 540 $DST5/$((OFFSET + i))
    grid_generation/grid_generation output/scview/$PREFIX1/video_$i/ours_180000/renders 960 540 $DST6/$((OFFSET + i))

done
