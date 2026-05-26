import numpy as np
import os
import shutil
import cv2
import math

workdir = "./data/EBS/Test1/EBS3"
numFrame = 1069
workdir1 = "./data/EBS/Test1/EBS3_REF"

testdir = os.path.join(workdir, "cam01")
reflist = []
ssdlist = [10000000000.0]
for i in range(2, numFrame+1, 1):
    filename1 = os.path.join(testdir, f"frame_{i:05d}.jpg")
    filename2 = os.path.join(testdir, f"frame_{i-1:05d}.jpg")
    img1 = cv2.imread(filename1)
    img2 = cv2.imread(filename2)

    ssdlist.append(np.sum((img1 - img2) ** 2))

sorted_index = [i for i, v in sorted(enumerate(ssdlist), key=lambda x:x[1], reverse=True)]
prune_index = []
frame_threshold = 30

for i in range(len(sorted_index)):
    if sorted_index[i] >= 0:
        prune_index.append(sorted_index[i])
    for j in range(i+1, len(sorted_index), 1):
        if sorted_index[j] > 0:
            if math.fabs(sorted_index[i] - sorted_index[j]) < frame_threshold:
                sorted_index[j] = -1
prune_index = sorted(prune_index[:20])

for cam in range(16):
    camdir1 = os.path.join(workdir, f"cam{cam+1:02d}")
    camdir2 = os.path.join(workdir1, f"cam{cam+1:02d}")
    os.makedirs(camdir2, exist_ok=True)
        
    for (i, idx) in enumerate(prune_index):
        filename1 = os.path.join(camdir1, f"frame_{idx+1:05d}.jpg")
        filename2 = os.path.join(camdir2, f"frame_{i+1:05d}.jpg")
        shutil.copy(filename1, filename2)

for i in range(len(prune_index)-1):
    for cam in range(16):
        camdir1 = os.path.join(workdir, f"cam{cam+1:02d}")    
        camdir2 = os.path.join(workdir + f"_{i}", f"cam{cam+1:02d}")
        os.makedirs(camdir2, exist_ok=True)

        for f in range(prune_index[i], prune_index[i+1]):
            filename1 = os.path.join(camdir1, f"frame_{f + 1:05d}.jpg")
            filename2 = os.path.join(camdir2, f"frame_{f + 1 - prune_index[i]:05d}.jpg")
            shutil.copy(filename1, filename2)


for cam in range(16):
    camdir1 = os.path.join(workdir, f"cam{cam+1:02d}")    
    camdir2 = os.path.join(workdir + f"_{len(prune_index)-1}", f"cam{cam+1:02d}")
    os.makedirs(camdir2, exist_ok=True)

    for f in range(prune_index[len(prune_index)-1], numFrame):
        filename1 = os.path.join(camdir1, f"frame_{f + 1:05d}.jpg")
        filename2 = os.path.join(camdir2, f"frame_{f + 1 - prune_index[len(prune_index)-1]:05d}.jpg")
        shutil.copy(filename1, filename2)

