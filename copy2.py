import os
import cv2
workdir = "data/EBS"
workdir1 = "data/EBS1"


for i in range(16):
    os.makedirs(os.path.join(workdir1, "cam{0:02d}".format(i)))
    for j in range(100):
        filename1 = os.path.join(workdir, "cam{0:02d}".format(i), "imaeg", "{0:04d}.png".format(j))
        filename2 = os.path.join(workdir1, "cam{0:02d}".format(i), "frame_{0:05d}.jpg")
        
        img = cv2.imread(filename1)


for folder in folder_list:
    path = os.path.join(workdir, str(folder), "images")
    file_list = os.listdir(path)
    
    file_list.sort()
    #file_list = sorted(file_list)
    for m in range(len(file_list)):
        if file_list[m].endswith(".png"):
            os.makedirs(os.path.join(workdir1, "cam{0:02d}".format(m), "images"), exist_ok=True)
            #print("cp " + os.path.join(path, file_list[m]) + " " + os.path.join(workdir1, "cam{0:02d}".format(m), "images", "{0:04d}.png".format(i)))
            os.system("cp " + os.path.join(path, file_list[m]) + " " + os.path.join(workdir1, "cam{0:02d}".format(m), "images", "{0:04d}.png".format(i)))
    i += 1
    if i == 100:
        break
        
        