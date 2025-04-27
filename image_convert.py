import cv2
import argparse
import os
parser = argparse.ArgumentParser()
parser.add_argument('scenedir', type=str, help='input scene directory')
parser.add_argument('outdir', type=str, help='input scene directory')

args = parser.parse_args()

if __name__=='__main__':
    image_folder = os.path.join(args.scenedir,"images")
    outdir = os.path.join(args.outdir,"images")
    os.makedirs(outdir,exist_ok=True)
    for i in range(16):
        image_path = os.path.join(image_folder,f"{i:03d}.png")
        out_path = os.path.join(outdir,f"{i:03d}.png")
        
        image = cv2.imread(image_path)
        image = cv2.resize(image, None, fx=0.5, fy=0.5, interpolation=cv2.INTER_LINEAR)
        cv2.imwrite(out_path, image)


