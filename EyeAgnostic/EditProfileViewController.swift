//
//  EditProfileViewController.swift
//  EyeAgnostic
//
//  Created by Derek Holley on 2015-11-21.
//  Copyright © 2015 Skeye Technologies. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate {
    
    var workingProfile: Profile?
    var picker:UIImagePickerController?=UIImagePickerController()
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var notesField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker?.delegate=self

        if let workingProfile = workingProfile {
            firstNameField.text = workingProfile.profileFirstName
            lastNameField.text = workingProfile.profileLastName
            dobField.text = workingProfile.birthDate
            notesField.text = workingProfile.additionalNotes
            //imageView.image = workingProfile.profileImage
        }
        
        if let image = workingProfile?.profileImage {
            photoButton.setImage(image, forState: .Normal)
        }
        photoButton.addTarget(self, action: "summonAlert", forControlEvents: .TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func summonAlert() {
        let alertController = UIAlertController(title: "New image", message: "Select method for adding image", preferredStyle: .Alert)
        
        let camAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.TakePhoto(self)
        }
        let galAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.OpenGallery(self)        }
        let CanAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) {
            UIAlertAction in }
        
        alertController.addAction(camAction)
        alertController.addAction(galAction)
        alertController.addAction(CanAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
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
            self.summonAlert()
        }
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoButton.setImage(pickedImage, forState: .Normal)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let firstName = firstNameField.text
        let lastName = lastNameField.text
        let date = dobField.text
        let notes = notesField.text
        let photo = photoButton.currentImage
        
        var scans = workingProfile?.profileScans
        if scans == nil {
            scans = []
        }
            
        // Set the case to be passed to TableViewController after the unwind segue.
        workingProfile = Profile(profileFirstName: firstName!, profileLastName: lastName!, profileImage: photo, birthDate: date!, additionalNotes: notes!, profileScans: scans)
    }

}
