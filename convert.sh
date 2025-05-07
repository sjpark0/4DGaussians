SET=$(seq 0 9)
for i in $SET
do
    mkdir -p data/EBS1/cam0$i
    ffmpeg -i data/EBS1/cam0$i.mp4 -vf fps=30 data/EBS1/cam0$i/frame_%05d.jpg
done

SET=$(seq 10 15)
for i in $SET
do
    mkdir -p data/EBS1/cam$i
    ffmpeg -i data/EBS1/cam$i.mp4 -vf fps=30 data/EBS1/cam$i/frame_%05d.jpg
done