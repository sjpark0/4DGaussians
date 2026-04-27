PREFIX=22_0704_titlesong2-1-2-41_out
SRC=../PlenopticServer1/$PREFIX/GS
#DST=../PlenopticServer2/2023-EBS/GRID49_GS_VIDEO_FINE/$PREFIX
DST1=../PlenopticServer2/GRID_GS_30000/$PREFIX
DST2=../PlenopticServer2/GRID_GS_60000/$PREFIX
DST3=../PlenopticServer2/GRID_GS_90000/$PREFIX
DST4=../PlenopticServer2/GRID_GS_120000/$PREFIX
DST5=../PlenopticServer2/GRID_GS_150000/$PREFIX
DST6=../PlenopticServer2/GRID_GS_180000/$PREFIX
DST7=../PlenopticServer2/GRID_GS_200000/$PREFIX
mkdir -p $DST1
mkdir -p $DST2
mkdir -p $DST3
mkdir -p $DST4
mkdir -p $DST5
mkdir -p $DST6
mkdir -p $DST7

#python copy_250521.py

#python train.py -s $SRC --port 6017 --expname "scview/$PREFIX" --configs arguments/scview/Sample.py --save_iterations 150000 180000 200000 --checkpoint_iterations 150000 180000 200000

#python render.py --model_path "output/scview/$PREFIX" --skip_train --focal 80.0 --view_range 1.0 --iteration 30000
#python render.py --model_path "output/scview/$PREFIX" --skip_train --focal 80.0 --view_range 1.0 --iteration 60000
#python render.py --model_path "output/scview/$PREFIX" --skip_train --focal 80.0 --view_range 1.0 --iteration 90000
#python render.py --model_path "output/scview/$PREFIX" --skip_train --focal 80.0 --view_range 1.0 --iteration 120000
#python render.py --model_path "output/scview/$PREFIX" --skip_train --focal 80.0 --view_range 1.0 --iteration 150000
#python render.py --model_path "output/scview/$PREFIX" --skip_train --focal 80.0 --view_range 1.0 --iteration 180000
#python render.py --model_path "output/scview/$PREFIX" --skip_train --focal 80.0 --view_range 1.0 --iteration 200000

OFFSET=0
SET1=$(seq 0 1 9)
for i in $SET1
do
#    grid_generation/grid_generation output/scview/$PREFIX/video_00$i/ours_30000/renders 960 540 $DST1/$((OFFSET + i))
#    grid_generation/grid_generation output/scview/$PREFIX/video_00$i/ours_60000/renders 960 540 $DST2/$((OFFSET + i))
#    grid_generation/grid_generation output/scview/$PREFIX/video_00$i/ours_90000/renders 960 540 $DST3/$((OFFSET + i))
#    grid_generation/grid_generation output/scview/$PREFIX/video_00$i/ours_120000/renders 960 540 $DST4/$((OFFSET + i))
#    grid_generation/grid_generation output/scview/$PREFIX/video_00$i/ours_150000/renders 960 540 $DST5/$((OFFSET + i))
#    grid_generation/grid_generation output/scview/$PREFIX/video_00$i/ours_180000/renders 960 540 $DST6/$((OFFSET + i))
    grid_generation/grid_generation output/scview/$PREFIX/video_00$i/ours_200000/renders 960 540 $DST7/$((OFFSET + i))

done

SET1=$(seq 10 1 99)
for i in $SET1
do
#    grid_generation/grid_generation output/scview/$PREFIX/video_0$i/ours_30000/renders 960 540 $DST1/$((OFFSET + i))
#    grid_generation/grid_generation output/scview/$PREFIX/video_0$i/ours_60000/renders 960 540 $DST2/$((OFFSET + i))
#    grid_generation/grid_generation output/scview/$PREFIX/video_0$i/ours_90000/renders 960 540 $DST3/$((OFFSET + i))
#    grid_generation/grid_generation output/scview/$PREFIX/video_0$i/ours_120000/renders 960 540 $DST4/$((OFFSET + i))
#    grid_generation/grid_generation output/scview/$PREFIX/video_0$i/ours_150000/renders 960 540 $DST5/$((OFFSET + i))
#    grid_generation/grid_generation output/scview/$PREFIX/video_0$i/ours_180000/renders 960 540 $DST6/$((OFFSET + i))
    grid_generation/grid_generation output/scview/$PREFIX/video_0$i/ours_200000/renders 960 540 $DST7/$((OFFSET + i))
    
done


SET1=$(seq 100 1 4288)
for i in $SET1
do
#    grid_generation/grid_generation output/scview/$PREFIX/video_$i/ours_30000/renders 960 540 $DST1/$((OFFSET + i))
#    grid_generation/grid_generation output/scview/$PREFIX/video_$i/ours_60000/renders 960 540 $DST2/$((OFFSET + i))
#    grid_generation/grid_generation output/scview/$PREFIX/video_$i/ours_90000/renders 960 540 $DST3/$((OFFSET + i))
#    grid_generation/grid_generation output/scview/$PREFIX/video_$i/ours_120000/renders 960 540 $DST4/$((OFFSET + i))
#    grid_generation/grid_generation output/scview/$PREFIX/video_$i/ours_150000/renders 960 540 $DST5/$((OFFSET + i))
#    grid_generation/grid_generation output/scview/$PREFIX/video_$i/ours_180000/renders 960 540 $DST6/$((OFFSET + i))
    grid_generation/grid_generation output/scview/$PREFIX/video_$i/ours_200000/renders 960 540 $DST7/$((OFFSET + i))

done
