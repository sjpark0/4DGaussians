
PREFIX=samul_still
SRC=../PlenopticServer1/250614_iPhone/$PREFIX
TEMP=data/$PREFIX

FOCAL=$(seq 5.0 2.0 20.0)
RANGE=$(seq 0.4 0.2 1.0)

mkdir -p $TEMP
SET1=$(seq 1402 1 1402)
for i in $SET1
do
    cp -r $SRC/IMG_$i $TEMP/IMG_$i
    mogrify -resize 25% -format png $TEMP/IMG_$i/images/*.png
    python train.py -s $TEMP/IMG_$i --port 6017 --expname "scview/$PREFIX/IMG_$i" --configs arguments/hypernerf/default.py
    

    cp -r output/scview/$PREFIX/IMG_$i/point_cloud $SRC/IMG_$i
    cp output/scview/$PREFIX/IMG_$i/cfg_args* $SRC/IMG_$i

    mkdir -p $SRC/IMG_$i/Export    
    for j in $FOCAL
    do
        for k in $RANGE
        do
            python render.py --model_path "output/scview/$PREFIX/IMG_$i" --skip_train --focal $j --view_range $k
            grid_generation/grid_generation output/scview/$PREFIX/IMG_$i/video/ours_14000/renders 540 960 $SRC/IMG_$i/Export/$j-$k    
        done
    done    
    
done

PREFIX=gayagum_still
SRC=../PlenopticServer1/250614_iPhone/$PREFIX
TEMP=data/$PREFIX

FOCAL=$(seq 5.0 2.0 20.0)
RANGE=$(seq 0.4 0.2 1.0)

mkdir -p $TEMP
SET1=$(seq 5387 1 5387)
for i in $SET1
do
    cp -r $SRC/IMG_$i $TEMP/IMG_$i
    mogrify -resize 50% -format png $TEMP/IMG_$i/images/*.png
    python train.py -s $TEMP/IMG_$i --port 6017 --expname "scview/$PREFIX/IMG_$i" --configs arguments/hypernerf/default.py
    

    cp -r output/scview/$PREFIX/IMG_$i/point_cloud $SRC/IMG_$i
    cp output/scview/$PREFIX/IMG_$i/cfg_args* $SRC/IMG_$i

    mkdir -p $SRC/IMG_$i/Export    
    for j in $FOCAL
    do
        for k in $RANGE
        do
            python render.py --model_path "output/scview/$PREFIX/IMG_$i" --skip_train --focal $j --view_range $k
            grid_generation/grid_generation output/scview/$PREFIX/IMG_$i/video/ours_14000/renders 540 960 $SRC/IMG_$i/Export/$j-$k    
        done
    done    
    
done
