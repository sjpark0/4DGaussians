import os
import sys
import glob

workdir = sys.argv[1]
renderdir = sys.argv[2]
iteration = int(sys.argv[3])
outdir = sys.argv[4]


workdir1 = os.path.join(workdir + "_REF", "cam01")
numImgs = len(glob.glob(workdir1 + "/*.jpg"))

for i in range(numImgs):
    renderdir1 = os.path.join(renderdir, f"REF/video_{i:03d}/ours_{iteration}/renders")
    outdir1 = os.path.join(outdir, f"{i}")
    os.system("grid_generation/grid_generation " + renderdir1 +  " 960 540 " + outdir1)