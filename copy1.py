import os
import cv2

workdir = "../PlenopticServer1/Diff/uniform/EBS_01_Subway_S2T1_out"
workdir1 = "data/scview/EBS3"

os.makedirs(workdir1, exist_ok=True)

folder_list = os.listdir(workdir)
#folder_list = sorted(folder_list)
folder_list = [int(folder) for folder in folder_list if not folder.startswith("Param")]
folder_list.sort()
i = 503
for folder in folder_list:
    path = os.path.join(workdir, str(folder), "images")
    file_list = os.listdir(path)
    file_list.sort()
    #file_list = sorted(file_list)
    for m in range(len(file_list)):
        if file_list[m].endswith(".png"):
            #os.makedirs(os.path.join(workdir1, "cam{0:02d}".format(m+1)), exist_ok=True)
            filename1 = os.path.join(path, file_list[m])
            filename2 = os.path.join(workdir1, "cam{0:02d}".format(m+1), "frame_{0:05d}.jpg".format(i - 503 + 1))
            img = cv2.imread(filename1)
            img1 = cv2.resize(img, dsize=(960, 540))
            cv2.imwrite(filename2, img1)

            #print("cp " + os.path.join(path, file_list[m]) + " " + os.path.join(workdir1, "cam{0:02d}".format(m), "images", "{0:04d}.png".format(i)))
            #os.system("cp " + os.path.join(path, file_list[m]) + " " + os.path.join(workdir1, "cam{0:02d}".format(m+1), "frame_{0:04d}.png".format(i - 503 + 1)))
    i += 1
    if i == 1571:
        break
        
        