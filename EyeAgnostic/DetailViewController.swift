//
//  DetailViewController.swift
//  EyeAgnostic
//
//  Created by Derek Holley on 2015-11-21.
//  Copyright © 2015 Skeye Technologies. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var currentProfile: Profile?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var lastDiagLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView?
    
    
    //@IBOutlet weak var cellDate: UILabel!
    //@IBOutlet weak var callResult: UILabel!
    //@IBOutlet weak var cellImage: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    let scanCellIdentifier = "ScanCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if currentProfile == nil {
            performSegueWithIdentifier("NewProfile", sender: self)
        } else {
            nameLabel.text = currentProfile!.profileFirstName + " " + currentProfile!.profileLastName
            dobLabel.text = "Date of Birth: " + currentProfile!.birthDate
            profileImage?.image = currentProfile!.profileImage
            //lastDiagLabel.text = dobLabel.text + currentProfile!.
            notesLabel.text = "Notes: " + currentProfile!.additionalNotes
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentProfile != nil {
            if currentProfile!.profileScans != nil {
                return currentProfile!.profileScans!.count
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(scanCellIdentifier, forIndexPath: indexPath) as! ScanTableViewCell
        
        let row = indexPath.row
        cell.scanDate.text? += " " + (currentProfile?.profileScans![row].imageDate)!
        if currentProfile?.profileScans![row].result == true {
            cell.scanResult.text? = "Result: Positive"
        } else {
            cell.scanResult.text? += "Result: Negative"
        }
        cell.scanImage.image = (currentProfile?.profileScans![row].addImage)
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EditProfile" {
            let editViewController = segue.destinationViewController as! EditProfileViewController
            
                editViewController.workingProfile = currentProfile
        } else if segue.identifier == "ShowScan" {
            let ScanView = segue.destinationViewController as! ScanViewController
                
            // Get the cell that generated this segue.
            if let selectedScanCell = sender as? ScanTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedScanCell)!
                let selectedScan = currentProfile?.profileScans![indexPath.row]
                ScanView.currentScan = selectedScan
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    @IBAction func unwindToProfileDetail(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? EditProfileViewController, workingProfile = sourceViewController.workingProfile {
            currentProfile = workingProfile
        }
    }
}
