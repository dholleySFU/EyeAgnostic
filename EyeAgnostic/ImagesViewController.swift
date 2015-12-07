//
//  ImagesViewController.swift
//  EyeAgnostic
//
//  Created by Derek Holley on 2015-11-05.
//  Copyright (c) 2015 Skeye Technologies. All rights reserved.
//

import UIKit
import SwiftyDropbox


class ImagesViewController: UIViewController, UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate {
    
    //Handles the opening, taking, and processing of new images.
    
    var picker:UIImagePickerController?=UIImagePickerController()
    var newBool: Bool?
    var results: Bool?
    
    //Position of the eyes
    var posLeftEye: CGPoint!
    var posRightEye: CGPoint!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker?.delegate=self
        summonAlert()
        
    }
    @IBAction func ReselectPic(sender: UIButton) {
        summonAlert()
    }
    
    func summonAlert() {
        let alertController = UIAlertController(title: "New image", message: "Select method for adding image", preferredStyle: .Alert)
        
        let camAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.TakePhoto(self)
        }
        let galAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.OpenGallery(self)
            
        }
        let CanAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) {
            UIAlertAction in }
        
        alertController.addAction(camAction)
        alertController.addAction(galAction)
        alertController.addAction(CanAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
        // Open Gallery button click
    @IBAction func OpenGallery(sender: AnyObject) {
        openGallary()
    }
    
    // Take Photo button click
    @IBAction func TakePhoto(sender: AnyObject) {
        openCamera()
    }
    
    @IBAction func ScanPhoto(sender: AnyObject) {
        analyzePhoto()
    }
    
    
    func openGallary()
    {
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(picker!, animated: true, completion: nil)
    }
    //------------------------------------------------------------------------------
    func analyzePhoto() {
        // SHANE: algorithm or related calls go here.
        //temp function:
        results = analyze()
            
            //CVWrapper.analyzeResultWithOpenCV(imageView.image)
            //imageView.image = CVWrapper.analyzeWithOpenCV(imageView.image) as UIImage
        print("analyzing")
        performSegueWithIdentifier("NewScanResult", sender: self)
    }
    
    
    
    func analyze() -> Bool{
        
        var rightEyeCancer: Bool = false
        var leftEyeCancer: Bool = false
        
        //If there are two eyes in the photo, check for cancer
        if(findEyes(imageView.image!)){
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
        let color : UIColor = (imageView.image?.getPixelColor(eyePos))!
        
        var white: CGFloat = 0
        
        color.getWhite(&white, alpha: nil)
        if(white > 0.65){
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

    
    
    
    //-------------------------------------------------------------------------------
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            picker!.allowsEditing = false
            picker!.sourceType = UIImagePickerControllerSourceType.Camera
            picker!.cameraCaptureMode = .Photo
            presentViewController(picker!, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style:.Default, handler: nil)
            alert.addAction(ok)
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "NewScanResult" {
            let controller:ScanViewController = segue.destinationViewController as! ScanViewController
            let ScanView = segue.destinationViewController as! ScanViewController
            controller.viewControllerNavigatedFrom = segue.sourceViewController
            
            // Get the cell that generated this segue.
            ScanView.currentImage = imageView.image
            ScanView.currentResult = results
            ScanView.newScanBool = newBool
        }
    }
    
}