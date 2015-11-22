//
//  EditProfileViewController.swift
//  EyeAgnostic
//
//  Created by Derek Holley on 2015-11-21.
//  Copyright © 2015 Skeye Technologies. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    var workingProfile: Profile?
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var notesField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let workingProfile = workingProfile {
            firstNameField.text = workingProfile.profileFirstName
            lastNameField.text = workingProfile.profileLastName
            dobField.text = workingProfile.birthDate
            notesField.text = workingProfile.additionalNotes
            imageView.image = workingProfile.profileImage
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let firstName = firstNameField.text
        let lastName = lastNameField.text
        let date = dobField.text
        let notes = notesField.text
        let photo = imageView.image
            
            
        // Set the case to be passed to TableViewController after the unwind segue.
        workingProfile = Profile(profileFirstName: firstName!, profileLastName: lastName!, profileImage: photo, birthDate: date!, additionalNotes: notes!, profileScans: workingProfile?.profileScans)
    }

}
