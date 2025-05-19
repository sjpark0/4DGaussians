SET1=$(seq 10 1 15)
PREFIX=IMG_1008

for i in $SET1
do
    python render.py --model_path "output/$PREFIX" --skip_train --focal $i
    mkdir -p PlenopticServer1/Jeonghyo/Sampling/$PREFIX/Export_GS_4/$i/
    cp -r output/$PREFIX/video/ours_14000/renders/* PlenopticServer1/Jeonghyo/Sampling/$PREFIX/Export_GS_4/$i/
done

PREFIX=IMG_1009
for i in $SET1
do
    python render.py --model_path "output/$PREFIX" --skip_train --focal $i
    mkdir -p PlenopticServer1/Jeonghyo/Sampling/$PREFIX/Export_GS_4/$i/
    cp -r output/$PREFIX/video/ours_14000/renders/* PlenopticServer1/Jeonghyo/Sampling/$PREFIX/Export_GS_4/$i/
done

PREFIX=IMG_1010
for i in $SET1
do
    python render.py --model_path "output/$PREFIX" --skip_train --focal $i
    mkdir -p PlenopticServer1/Jeonghyo/Sampling/$PREFIX/Export_GS_4/$i/
    cp -r output/$PREFIX/video/ours_14000/renders/* PlenopticServer1/Jeonghyo/Sampling/$PREFIX/Export_GS_4/$i/
done

PREFIX=IMG_1011
for i in $SET1
do
    python render.py --model_path "output/$PREFIX" --skip_train --focal $i
    mkdir -p PlenopticServer1/Jeonghyo/Sampling/$PREFIX/Export_GS_4/$i/
    cp -r output/$PREFIX/video/ours_14000/renders/* PlenopticServer1/Jeonghyo/Sampling/$PREFIX/Export_GS_4/$i/
done

PREFIX=IMG_1012
for i in $SET1
do
    python render.py --model_path "output/$PREFIX" --skip_train --focal $i
    mkdir -p PlenopticServer1/Jeonghyo/Sampling/$PREFIX/Export_GS_4/$i/
    cp -r output/$PREFIX/video/ours_14000/renders/* PlenopticServer1/Jeonghyo/Sampling/$PREFIX/Export_GS_4/$i/
done

PREFIX=IMG_1013
for i in $SET1
do
    python render.py --model_path "output/$PREFIX" --skip_train --focal $i
    mkdir -p PlenopticServer1/Jeonghyo/Sampling/$PREFIX/Export_GS_4/$i/
    cp -r output/$PREFIX/video/ours_14000/renders/* PlenopticServer1/Jeonghyo/Sampling/$PREFIX/Export_GS_4/$i/
done