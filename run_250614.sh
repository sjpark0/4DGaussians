PREFIX=samul_still
sh colmap_sparse.sh data/250614_iPhone/$PREFIX/IMG_1401

SET1=$(seq 1403 1 1427)
for i in $SET1
do
    sh colmap_sparse.sh data/250614_iPhone/$PREFIX/IMG_$i
done

PREFIX=sogo_still
SET1=$(seq 1430 1 1450)
for i in $SET1
do
    sh colmap_sparse.sh data/250614_iPhone/$PREFIX/IMG_$i
done

PREFIX=gayagum_still
SET1=$(seq 1468 1 1480)
for i in $SET1
do
    sh colmap_sparse.sh data/250614_iPhone/$PREFIX/IMG_$i
done
SET1=$(seq 5383 1 5387)
for i in $SET1
do
    sh colmap_sparse.sh data/250614_iPhone/$PREFIX/IMG_$i
done

#PREFIX=uniform/EBS_01_Subway_S2T1_out
#SRC=../PlenopticServer1/Diff/$PREFIX
#DST1=../PlenopticServer2/2023-EBS/GRID49_GS_960_540_1000/$PREFIX
#DST2=../PlenopticServer2/2023-EBS/GRID49_GS_960_540_3000/$PREFIX
#DST3=../PlenopticServer2/2023-EBS/GRID49_GS_960_540_14000/$PREFIX

#TEMP=data/$PREFIX
#mkdir -p $DST1
#mkdir -p $DST2
#mkdir -p $DST3

#mkdir -p $TEMP/images
#cp -r $SRC/Param/* $TEMP


#SET1=$(seq 714 1 1571)
#for i in $SET1
#do
    #cp $SRC/$i/images/*.png $TEMP/images
    #mogrify -resize 25% -format png $TEMP/images/*.png
    #python train.py -s $TEMP --port 6017 --expname "scview/$PREFIX/$i" --configs arguments/hypernerf/default.py --save_iterations 1000 3000 14000
    #python render.py --model_path "output/scview/$PREFIX/$i" --skip_train --focal 80.0 --iteration 1000
    #python render.py --model_path "output/scview/$PREFIX/$i" --skip_train --focal 80.0 --iteration 3000
    #python render.py --model_path "output/scview/$PREFIX/$i" --skip_train --focal 80.0 --iteration 14000

    #grid_generation/grid_generation output/scview/$PREFIX/$i/video/ours_1000/renders 960 540 $DST1/$i
    #grid_generation/grid_generation output/scview/$PREFIX/$i/video/ours_3000/renders 960 540 $DST2/$i
    #grid_generation/grid_generation output/scview/$PREFIX/$i/video/ours_14000/renders 960 540 $DST3/$i
#done

