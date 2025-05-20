PREFIX=24_video
SRC=./PlenopticServer1/source/$PREFIX
DST=./PlenopticServer2/2024-Photo/$PREFIX

mkdir -p $DST/Export_30000
mkdir -p $DST/Export_60000
mkdir -p $DST/Export_90000
mkdir -p $DST/Export_120000
mkdir -p $DST/Export_150000
mkdir -p $DST/Export_180000
mkdir -p $DST/Export_200000

#python train.py -s $SRC --port 6017 --expname "scview/$PREFIX" --configs arguments/scview/Sample.py --save_iterations 30000 60000 90000 120000 150000 180000 200000
python render.py --model_path "output/scview/$PREFIX" --skip_train --focal 10.0 --view_range 0.6 --iteration 150000
    
SET1=$(seq 0 1 9)
for i in $SET1
do
    grid_generation/grid_generation output/scview/$PREFIX/video_00$i/ours_200000/renders 540 960 $DST/Export_150000/$i
done

SET1=$(seq 10 1 99)
for i in $SET1
do
    grid_generation/grid_generation output/scview/$PREFIX/video_0$i/ours_200000/renders 540 960 $DST/Export_150000/$i
done

SET1=$(seq 100 1 1068)
for i in $SET1
do
    grid_generation/grid_generation output/scview/$PREFIX/video_$i/ours_200000/renders 540 960 $DST/Export_150000/$i
done
