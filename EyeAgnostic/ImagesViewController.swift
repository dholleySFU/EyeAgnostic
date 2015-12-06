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
    
    func analyzePhoto() {
        // SHANE: algorithm or related calls go here.
        //temp function:
        results = CVWrapper.analyzeResultWithOpenCV(imageView.image)
        imageView.image = CVWrapper.analyzeWithOpenCV(imageView.image) as UIImage
        print("analyzing")
        performSegueWithIdentifier("NewScanResult", sender: self)
    }
    
    
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