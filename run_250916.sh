PREFIX=9
SRC=../PlenopticServer1/16inch_sync/Sequence/$PREFIX
DST1=../PlenopticServer2/2025-JeongHyo/16inch_sync/GRID49_GS_Original_1000/$PREFIX/9-0.6
DST2=../PlenopticServer2/2025-JeongHyo/16inch_sync/GRID49_GS_Original_3000/$PREFIX/9-0.6
DST3=../PlenopticServer2/2025-JeongHyo/16inch_sync/GRID49_GS_Original_14000/$PREFIX/9-0.6

TEMP=data/$PREFIX
mkdir -p $TEMP
mkdir -p $DST1
mkdir -p $DST2
mkdir -p $DST3

mkdir -p $TEMP/images
#cp -r $SRC/Param/* $TEMP


SET1=$(seq 204 1 6473)
for i in $SET1
do
    cp $SRC/$i/*.png $TEMP/images
    mogrify -resize 25% -format png $TEMP/images/*.png
    python train.py -s $TEMP --port 6017 --expname "scview/$PREFIX/$i" --configs arguments/hypernerf/default.py --save_iterations 1000 3000 14000
    python render.py --model_path "output/scview/$PREFIX/$i" --skip_train --focal 9.0 --view_range 0.6 --iteration 1000
    python render.py --model_path "output/scview/$PREFIX/$i" --skip_train --focal 9.0 --view_range 0.6  --iteration 3000
    python render.py --model_path "output/scview/$PREFIX/$i" --skip_train --focal 9.0 --view_range 0.6  --iteration 14000

    grid_generation/grid_generation output/scview/$PREFIX/$i/video/ours_1000/renders 960 540 $DST1/$i
    grid_generation/grid_generation output/scview/$PREFIX/$i/video/ours_3000/renders 960 540 $DST2/$i
    grid_generation/grid_generation output/scview/$PREFIX/$i/video/ours_14000/renders 960 540 $DST3/$i
done

