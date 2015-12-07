//
//  ViewController.swift
//  Eyeagnostics
//
//  Created by Shane Nilsson on 2015-11-01.
//  Copyright © 2015 Skeye Technologies. All rights reserved.
//

import UIKit
import CoreImage

extension UIImage {
    func getPixelColor(pos: CGPoint) -> UIColor {
        
        let pixelData = CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage))
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }  
}

class ViewController{
    

    
    //Photo to analyze
    var photoImageView = UIImageView(frame: CGRectMake(100, 100, 150, 150))
    
    //Position of the eyes
    var posLeftEye: CGPoint!
    var posRightEye: CGPoint!
    

    
    func analyzeImage() {
            analyze()

    }
    
    func analyze() -> Bool{
        
        var rightEyeCancer: Bool = false
        var leftEyeCancer: Bool = false
        
        //If there are two eyes in the photo, check for cancer
        if(findEyes(photoImageView.image!)){
            //Check Right Eye
            rightEyeCancer = analyzeEye(posRightEye)
            //Check Left Eye
            leftEyeCancer = analyzeEye(posLeftEye)
            
            //If one of the eyes has cancer, alarm bells
            if(rightEyeCancer || leftEyeCancer){
                if(rightEyeCancer && !leftEyeCancer){
                    //statusLabel.text = "Possible cancer detected in right eye"
                }
                if(!rightEyeCancer && leftEyeCancer){
                    //statusLabel.text = "Possible cancer detected in left eye"
                }
                if(rightEyeCancer && leftEyeCancer){
                    //statusLabel.text = "Possible cancer detected in both eyes"
                }
                return true
            } else {
                //statusLabel.text = "No cancer detected"
                return false
            }
            
            //Could not locate eyes in photo
        } else{
            //statusLabel.text = "Could not find eye"
        }
        return false
    }
    
    func analyzeEye(eyePos: CGPoint) -> Bool{
        let color : UIColor = (photoImageView.image?.getPixelColor(eyePos))!
        
        var white: CGFloat = 0
        
        color.getWhite(&white, alpha: nil)
        if(white > 0.5){
            return true;
        } else {
            return false;
        }
        
    }
    
    func findEyes(inputImage: UIImage) ->Bool{
        
        var rightEyeFound: Bool = false
        var leftEyeFound: Bool = false
        
        
        let ciImage = CIImage(CGImage: inputImage.CGImage!)
        
        let options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: options)
        
        let faces = faceDetector.featuresInImage(ciImage)
        
        if let face = faces.first as? CIFaceFeature {
            print("Found face at \(face.bounds)")
            //Left Eye Detection
            if face.hasLeftEyePosition {
                print("Found left eye at \(face.leftEyePosition)")
                //Checks to see if the left eye is open
                if(!face.leftEyeClosed){
                    leftEyeFound = true
                    posLeftEye = face.leftEyePosition;
                } else {
                    print("Left eye appears to be closed")
                }
            } else {
                print("No left eye found")
            }
            
            //Right Eye Detection
            if face.hasRightEyePosition {
                print("Found right eye at \(face.rightEyePosition)")
                //Checks to see if the right eye is open
                if(!face.rightEyeClosed){
                    rightEyeFound = true
                    posRightEye = face.rightEyePosition;
                } else {
                    print("Right eye appears to be closed")
                }
                
            } else {
                print("No right eye found")
            }
            
        } else {
            print ("no faces found")
        }
        
        if(rightEyeFound && leftEyeFound){
            return true
        } else {
            return false
        }
    }

    
    
}

