PREFIX=gayagum_still
SRC=../PlenopticServer1/250614_iPhone/$PREFIX
TEMP=data/$PREFIX


#DST1=../PlenopticServer2/2023-EBS/GRID49_GS_960_540_1000/$PREFIX
#DST2=../PlenopticServer2/2023-EBS/GRID49_GS_960_540_3000/$PREFIX
#DST3=../PlenopticServer2/2023-EBS/GRID49_GS_960_540_14000/$PREFIX

#TEMP=data/$PREFIX
#mkdir -p $DST1
#mkdir -p $DST2
#mkdir -p $DST3

#mkdir -p $TEMP/images
#cp -r $SRC/Param/* $TEMP


SET1=$(seq 5383 1 5383)
SET2=$(seq 5.0 2.0 20.0)
SET3=$(seq 0.4 0.2 1.0)

mkdir -p $TEMP    
for i in $SET1
do
    mkdir -p $SRC/IMG_$i/Export
    cp -r $SRC/IMG_$i/ $TEMP

    mogrify -resize 50% -format png $TEMP/IMG_$i/images/*.png
    python train.py -s $TEMP/IMG_$i --port 6017 --expname "scview/$PREFIX/IMG_$i" --configs arguments/hypernerf/default.py
    for j in $SET2
    do
        for k in $SET3
        do
            python render.py --model_path "output/scview/$PREFIX/IMG_$i" --skip_train --focal $j --view_range $k
            grid_generation/grid_generation output/scview/$PREFIX/IMG_$i/video/ours_14000/renders 540 960 $SRC/IMG_$i/Export/$j-$k
        done
    done    
done
    #python render.py --model_path "output/scview/$PREFIX/$i" --skip_train --focal 80.0 --iteration 1000
    #python render.py --model_path "output/scview/$PREFIX/$i" --skip_train --focal 80.0 --iteration 3000
    #python render.py --model_path "output/scview/$PREFIX/$i" --skip_train --focal 80.0 --iteration 14000

    #grid_generation/grid_generation output/scview/$PREFIX/$i/video/ours_1000/renders 960 540 $DST1/$i
    #grid_generation/grid_generation output/scview/$PREFIX/$i/video/ours_3000/renders 960 540 $DST2/$i
    #grid_generation/grid_generation output/scview/$PREFIX/$i/video/ours_14000/renders 960 540 $DST3/$i
#done

