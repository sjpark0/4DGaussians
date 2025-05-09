SET1=$(seq 10 10 100)
PREFIX=IMG_1009

python train.py -s data/$PREFIX --port 6017 --expname "$PREFIX" --configs arguments/hypernerf/default.py
for i in $SET1
do
    python render.py --model_path "output/$PREFIX" --skip_train --focal $i
    mkdir ../PlenopticServer1/Jeonghyo/Sampling/$PREFIX/Export_GS/$i/
    cp -r output/$PREFIX/video/ours_14000/renders/* ../PlenopticServer1/Jeonghyo/Sampling/$PREFIX/Export_GS/$i/
done

SET1=$(seq 10 10 100)
PREFIX=IMG_1010

python train.py -s data/$PREFIX --port 6017 --expname "$PREFIX" --configs arguments/hypernerf/default.py
for i in $SET1
do
    python render.py --model_path "output/$PREFIX" --skip_train --focal $i
    mkdir ../PlenopticServer1/Jeonghyo/Sampling/$PREFIX/Export_GS/$i/
    cp -r output/$PREFIX/video/ours_14000/renders/* ../PlenopticServer1/Jeonghyo/Sampling/$PREFIX/Export_GS/$i/
done

SET1=$(seq 10 10 100)
PREFIX=IMG_1011

python train.py -s data/$PREFIX --port 6017 --expname "$PREFIX" --configs arguments/hypernerf/default.py
for i in $SET1
do
    python render.py --model_path "output/$PREFIX" --skip_train --focal $i
    mkdir ../PlenopticServer1/Jeonghyo/Sampling/$PREFIX/Export_GS/$i/
    cp -r output/$PREFIX/video/ours_14000/renders/* ../PlenopticServer1/Jeonghyo/Sampling/$PREFIX/Export_GS/$i/
done

SET1=$(seq 10 10 100)
PREFIX=IMG_1012

python train.py -s data/$PREFIX --port 6017 --expname "$PREFIX" --configs arguments/hypernerf/default.py
for i in $SET1
do
    python render.py --model_path "output/$PREFIX" --skip_train --focal $i
    mkdir ../PlenopticServer1/Jeonghyo/Sampling/$PREFIX/Export_GS/$i/
    cp -r output/$PREFIX/video/ours_14000/renders/* ../PlenopticServer1/Jeonghyo/Sampling/$PREFIX/Export_GS/$i/
done

SET1=$(seq 10 10 100)
PREFIX=IMG_1013

python train.py -s data/$PREFIX --port 6017 --expname "$PREFIX" --configs arguments/hypernerf/default.py
for i in $SET1
do
    python render.py --model_path "output/$PREFIX" --skip_train --focal $i
    mkdir ../PlenopticServer1/Jeonghyo/Sampling/$PREFIX/Export_GS/$i/
    cp -r output/$PREFIX/video/ours_14000/renders/* ../PlenopticServer1/Jeonghyo/Sampling/$PREFIX/Export_GS/$i/
done