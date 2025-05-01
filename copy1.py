import os

workdir = "data/scview1"
workdir1 = "data/scview/"

folder_list = os.listdir(workdir1)
folder_list = sorted(folder_list)
i = 0
for folder in folder_list:
    if folder.startswith("cam") and not folder.endswith(".mp4"):
        path = os.path.join(workdir1, folder + "/images")
        file_list = os.listdir(path)
        file_list = sorted(file_list)
        for m in range(len(file_list)):
            os.makedirs(os.path.join(workdir, str(m) + "/images"), exist_ok=True)
            #print("cp" + os.path.join(path, file_list[m]) + os.path.join(workdir, str(m) + "/images/" + "{03d}.png".format(i)))
            os.system("cp " + os.path.join(path, file_list[m]) + " " + os.path.join(workdir, str(m) + "/images/" + "{0:03d}.png".format(i)))
        i += 1
        
        #break
        #path = os.path.join(workdir1, folder + "/images")
        #file_list = os.listdir(path)
        #file_list = sorted(file_list)
        #for i in range(len(file_list)):
        #    os.makedirs(os.path.join(workdir, str(i) + "/images"), exist_ok=True)
        
        #for file in file_list:
        #    if file.endswith(".png"):
        #        src = os.path.join(path, file)
        #        #dst = os.path.join(workdir, folder + "_" + file)
        #        #print(src, dst)
        #        #os.system("cp " + src + " " + dst)