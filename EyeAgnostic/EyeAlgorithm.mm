//
//  EyeAlgorithm.cpp
//
//  Created by Shane Nilsson on 2015-11-01.
//  Copyright © 2015 ellipsis.com. All rights reserved.
//

#include "EyeAlgorithm.h"

using namespace std;
using namespace cv;
//-------------------------------------


/** @function detectAndDisplay */
int detectAndDisplay( Mat frame )
{
    int numOfEyes = 0;
    vector<Rect> faces;
    Mat frame_gray;
    
    cvtColor( frame, frame_gray, CV_BGR2GRAY );
    equalizeHist( frame_gray, frame_gray );
    
    //-- Detect faces
    face_cascade.detectMultiScale( frame_gray, faces, 1.1, 2, 0|CV_HAAR_SCALE_IMAGE, Size(30, 30) );
    
    for( size_t i = 0; i < faces.size(); i++ )
    {
        Point center( faces[i].x + faces[i].width*0.5, faces[i].y + faces[i].height*0.5 );
        ellipse( frame, center, Size( faces[i].width*0.5, faces[i].height*0.5), 0, 0, 360, Scalar( 255, 0, 255 ), 4, 8, 0 );
        
        Mat faceROI = frame_gray( faces[i] );
        vector<Rect> eyes;
        
        //-- In each face, detect eyes
        eyes_cascade.detectMultiScale( faceROI, eyes, 1.1, 2, 0 |CV_HAAR_SCALE_IMAGE, Size(30, 30) );
        
        for( size_t j = 0; j < eyes.size(); j++ )
        {
            Point center( faces[i].x + eyes[j].x + eyes[j].width*0.5, faces[i].y + eyes[j].y + eyes[j].height*0.5 );
            int radius = cvRound( (eyes[j].width + eyes[j].height)*0.25 );
            circle( frame, center, radius, Scalar( 255, 0, 0 ), 4, 8, 0 );
            printf(" there's an eye\n");
            
            switch(j){
                case 0:
                    eye1 = extractEye(src, center, radius);
                    imshow("Eye 1", eye1);
                    break;
                case 1:
                    eye2 = extractEye(src, center, radius);
                    imshow("Eye 2", eye2);
                    break;
            }
            
            
        }
        numOfEyes = eyes.size();
    }
    //-- Show what you got
    //imshow( window_name, frame );
    return numOfEyes;
}

Mat extractEye(Mat src, Point center, int radius){
    Rect myROI(center.x - radius, center.y - radius,radius*2, radius*2);
    Mat croppedRef(src, myROI);
    Mat cropped;
    croppedRef.copyTo(cropped);
    return cropped;
}