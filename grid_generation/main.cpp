#include <stdio.h>

#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/videoio.hpp>
using namespace cv;


int main(int argc, const char* argv[]) {
  int gridWidth = atoi(argv[2]);
  int gridHeight = atoi(argv[3]);
  int cols = 7;
  int rows = 7;
  int width = gridWidth * cols;
  int height = gridHeight * rows;
  Mat outImage(height, width, CV_8UC3);
  Mat img;
  Mat resizeImg;
  char filename[1024];
  int x, y;
  for(int i=0;i<cols * rows;i++){
    x = i % cols;
    y = i / cols;
    
    sprintf(filename, "%s/%05d.png", argv[1], i);
    img = imread(filename);
    resize(img, resizeImg, Size(gridWidth, gridHeight));
    resizeImg.copyTo(outImage(Rect(x * gridWidth, (rows - y - 1) * gridHeight, gridWidth, gridHeight)));
  }
  sprintf(filename, "%s_qs%dx%d.png", argv[4], cols, rows);
  imwrite(filename, outImage);
}
