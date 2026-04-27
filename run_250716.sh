PREFIX=Background/Namsan
SRC=../PlenopticServer1/Diff/$PREFIX
DST=../PlenopticServer1/$PREFIX/GS_Export

TEMP=data/$PREFIX
mkdir -p $DST
#sh scview.sh $TEMP
python imgs2poses.py $TEMP
python train.py -s $TEMP --port 6017 --expname "scview/$PREFIX" --configs arguments/hypernerf/default.py 
SET=$(seq 20.0 1.0 50.0)
for i in $SET
do
    python render.py --model_path "output/scview/$PREFIX" --skip_train --focal $i --iteration 14000
    grid_generation/grid_generation output/scview/$PREFIX/video/ours_14000/renders 1920 1080 $DST/$i
done


