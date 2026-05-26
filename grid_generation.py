import os
import sys
import glob

workdir = sys.argv[1]
num = int(sys.argv[2])
renderdir = sys.argv[3]
iteration = int(sys.argv[4])
outdir = sys.argv[5]
totalnum = int(sys.argv[6])

num_list = []
for i in range(totalnum):
    workdir1 = os.path.join(workdir + f"_{i}", "cam01")
    num_list.append(len(glob.glob(workdir1 + "/*.jpg")))

print(num_list)

next_num = sum(num_list[0:num])

for i in range(num_list[num]):
    renderdir1 = os.path.join(renderdir, f"{num}/video_{i:03d}/ours_{iteration}/renders")
    outdir1 = os.path.join(outdir, f"{next_num+i}")
    os.system("grid_generation/grid_generation " + renderdir1 +  " 960 540 " + outdir1)