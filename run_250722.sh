PREFIX=22_0704_titlesong2-1-2-41_out
#DST=../PlenopticServer2/2023-EBS/GRID49_GS_VIDEO_FINE/$PREFIX
DST1=../PlenopticServer2/2025-JeongHyo/16inch_sync/GRID49_GS_30_15000/9/9-0.6
mkdir -p $DST1

SRC=./data/16inch_sync/9

#python copy_250722.py 
#sh scviewprocess_250722.sh $SRC

#python copy_250724.py

SET=$(seq 58 1 208)
#SET="0 1"
for num in $SET
do
    SRC=./data/16inch_sync/9_$num
    rm -rf colmap_tmp/dense
    sh scviewprocess_250724.sh $SRC
    python train.py -s $SRC --port $((num + 6000)) --expname "scview/2025-JeongHyo/$num" --configs arguments/scview/default.py --save_iterations 15000 --checkpoint_iterations 15000
    python render.py --model_path "output/scview/2025-JeongHyo/$num" --skip_train --focal 9.0 --view_range 0.6 --iteration 15000

    SET1=$(seq 0 1 9)
    for i in $SET1
    do
        grid_generation/grid_generation output/scview/2025-JeongHyo/$num/video_00$i/ours_15000/renders 960 540 $DST1/$((num * 30 + i))
    done

    SET1=$(seq 10 1 29)
    for i in $SET1
    do
        grid_generation/grid_generation output/scview/2025-JeongHyo/$num/video_0$i/ours_15000/renders 960 540 $DST1/$((num * 30 + i))
        
    done

done
