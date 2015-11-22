//
//  NewCaseViewController.swift
//  EyeAgnostic
//
//  Created by Derek Holley on 2015-11-08.
//  Copyright (c) 2015 Skeye Technologies. All rights reserved.
//
/*
import UIKit

class NewCaseViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: Properties
    
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var DateField: UITextField!
    @IBOutlet weak var NotesField: UITextField!
    @IBOutlet weak var CaseImage: UIImageView!
    @IBOutlet weak var SaveButton: UIBarButtonItem!
    var CaseAdditionals: [UIImage]!
    
    
    /*
    This value is either passed by `CaseTableViewController` in `prepareForSegue(_:sender:)`
    or constructed as part of adding a new case.
    */
    var newCase: Case?
    var picker:UIImagePickerController?=UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        NameField.delegate = self
        picker?.delegate = self
        
        if let newCase = newCase {
            NameField.text   = newCase.caseName
            DateField.text = newCase.caseDate
            NotesField.text = newCase.caseNotes
            CaseImage.image = newCase.caseImage
        }
        
        //CaseImage.contentMode = .ScaleAspectFit
        
        // Enable the Save button only if the text field has a valid Case name.
        checkValidName()
    }
    
    @IBAction func OpenGallery(sender: AnyObject) {
        openGallary()
    }
    
    // Take Photo button click
    @IBAction func TakePhoto(sender: AnyObject) {
        openCamera()
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidName()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        SaveButton.enabled = false
    }
    
    func checkValidName() {
        // Disable the Save button if the text field is empty.
        let text = NameField.text ?? ""
        SaveButton.enabled = !text.isEmpty
    }
    
    // MARK: UIImagePickerControllerDelegate
    
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
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //imageView.contentMode = .ScaleAspectFit
            CaseImage.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: Navigation
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if SaveButton === sender {
            let name = NameField.text ?? ""
            let date = DateField.text
            let notes = NotesField.text
            let photo = CaseImage.image
            
            
            // Set the case to be passed to TableViewController after the unwind segue.
            newCase = Case(caseName: name, caseDate: date!, caseImage: photo, caseNotes: notes!, caseAdditionals: CaseAdditionals)
        }
    }
}
*/
