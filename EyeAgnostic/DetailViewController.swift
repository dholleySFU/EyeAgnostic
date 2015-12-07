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
            if currentProfile!.profileScans!.count != 0 {
                lastDiagLabel.text = "Last Scan: " + currentProfile!.profileScans![0].imageDate
            } else {
                lastDiagLabel.text = "Last Scan: "
            }
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
            }
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(scanCellIdentifier, forIndexPath: indexPath) as! ScanTableViewCell
        
        let row = indexPath.row
        cell.scanDate.text = "Date: " + (currentProfile?.profileScans![row].imageDate)!
        if currentProfile?.profileScans![row].result == true {
            cell.scanResult.text? = "Result: Positive"
        } else {
            cell.scanResult.text? = "Result: Negative"
        }
        cell.scanImage.image = (currentProfile?.profileScans![row].addImage)
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            currentProfile!.profileScans!.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EditProfile" {
            let editViewController = segue.destinationViewController as! EditProfileViewController
            
                editViewController.workingProfile = currentProfile
        } else if segue.identifier == "ShowScan" {
            let ScanView = segue.destinationViewController as! ScanViewController
            let controller:ScanViewController = segue.destinationViewController as! ScanViewController
            controller.viewControllerNavigatedFrom = segue.sourceViewController
                
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
        else if let sourceViewController = sender.sourceViewController as? ScanViewController, newScan = sourceViewController.currentScan {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing Profile.
                currentProfile?.profileScans![selectedIndexPath.row] = newScan
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                currentProfile?.profileScans?.insert(newScan, atIndex: 0)
                let newIndexPath = NSIndexPath(forRow: 0, inSection: 0)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Top)
            }
        }
    }
}
