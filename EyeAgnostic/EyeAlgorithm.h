//
//  EyeAlgorithm.hpp
//  SwiftStitch
//
//  Created by Shane Nilsson on 2015-12-01.
//  Copyright © 2015 ellipsis.com. All rights reserved.
//


#ifndef CVOpenTemplate_Header_h
#define CVOpenTemplate_Header_h
#include <opencv2/opencv.hpp>
#include <opencv2/objdetect/objdetect.hpp>
#include <opencv2/highgui/highgui.hpp>
//#include <opencv2/imgcodecs.hpp>
#include <opencv2/imgproc/imgproc.hpp>
//#include <opencv2/features2d.hpp>

cv::Mat stitch (std::vector <cv::Mat> & images);

int eyeAnalyze(cv::Mat src);
int detectAndDisplay( cv::Mat frame );
cv::Mat extractEye(cv::Mat src, cv::Point point, int radius);
cv::Mat detectBlob(cv::Mat frame);

/** Global variables */
std::string face_cascade_name = "haarcascade_frontalface_alt.xml";
std::string eyes_cascade_name = "haarcascade_eye.xml";
cv::CascadeClassifier face_cascade;
cv::CascadeClassifier eyes_cascade;
//RNG rng(12345);

cv::Mat src; cv::Mat dst; cv::Mat detectFace;

cv::Mat eye1; cv::Mat eye2;
cv::Mat eye1Trace; cv::Mat eye2Trace;
cv::Mat eye1Blob; cv::Mat eye2Blob;

#endif
