import os
import cv2

workdir = "./data/scview/EBS3"


step = 100
for m in range(1, 1069, step):
    num = m // step
    workdir1 = "./data/scview/EBS3_" + str(num)
    for i in range(16):
        os.makedirs(os.path.join(workdir1, "cam{0:02d}".format(i+1)), exist_ok=True)
    for n in range(step):
        
        for i in range(16):
            os.system("cp " + os.path.join(workdir, "cam{0:02d}".format(i+1), "frame_{0:05d}.jpg".format(m+n)) + " " + os.path.join(workdir1, "cam{0:02d}".format(i+1), "frame_{0:05d}.jpg".format(n+1)))

    #os.system("cp -r " + os.path.join(workdir, "sparse_") + " " + workdir1)
    #os.system("cp " + os.path.join(workdir, "points3D_scview.ply") + " " + workdir1)
    #os.system("cp " + os.path.join(workdir, "poses_bounds_scview.npy") + " " + workdir1)
    