import os
import cv2

workdir = "../PlenopticServer1/16inch_sync/Sequence/9"
workdir1 = "./data/16inch_sync/9"

os.makedirs(workdir1, exist_ok=True)

for i in range(203, 6473, 1):
    path = os.path.join(workdir, str(i))
    file_list = os.listdir(path)
    file_list.sort()
    #file_list = sorted(file_list)
    for m in range(16):
        os.makedirs(os.path.join(workdir1, "cam{0:02d}".format(m+1)), exist_ok=True)
    
    for m in range(16):
        if file_list[m].endswith(".png"):
            #os.makedirs(os.path.join(workdir1, "cam{0:02d}".format(m+1)), exist_ok=True)
            filename1 = os.path.join(path, file_list[m])
            filename2 = os.path.join(workdir1, "cam{0:02d}".format(m+1), "frame_{0:05d}.jpg".format(i - 202))
            img = cv2.imread(filename1)
            img1 = cv2.resize(img, dsize=(960, 540))
            cv2.imwrite(filename2, img1)

            #print("cp " + os.path.join(path, file_list[m]) + " " + os.path.join(workdir1, "cam{0:02d}".format(m), "images", "{0:04d}.png".format(i)))
            #os.system("cp " + os.path.join(path, file_list[m]) + " " + os.path.join(workdir1, "cam{0:02d}".format(m+1), "frame_{0:04d}.png".format(i - 503 + 1)))
    