//
//  ProfileTableViewController.swift
//  EyeAgnostic
//
//  Created by Derek Holley on 2015-11-20.
//  Copyright © 2015 Skeye Technologies. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    var profiles: [Profile] = []
    
    func loadSampleData(){
        let photo1 = UIImage(named: "Avery-Fitzgerald.jpg")!
        let scan1 = ScanClass(imageDate: "2010-03-02", addImage: photo1, imageTime: "16:00", result: true)
        let sample1 = Profile(profileFirstName: "Avery", profileLastName: "Fitzerald", profileImage: photo1, birthDate: "2008-06-12", additionalNotes: "", profileScans: [scan1, scan1, scan1, scan1])
        let photo2 = UIImage(named: "retino1.jpg")!
        let sample2 = Profile(profileFirstName: "Matthew", profileLastName: "Kelly", profileImage: photo2, birthDate: "2004-01-01", additionalNotes: "", profileScans: nil)
        
        profiles += [sample1, sample2]
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedProfiles = loadProfiles() {
           profiles += savedProfiles
        }
        
        if profiles.isEmpty {
            loadSampleData()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return profiles.count
    }
    
    // MARK: Saving
    
    func saveProfiles() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(profiles, toFile: Profile.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save profiles.", terminator: "")
        }
    }
    
    func loadProfiles() -> [Profile]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Profile.ArchiveURL.path!) as? [Profile]
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ProfCellTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ProfCellTableViewCell
        
        //Fetch cse for layout
        let sampleProf = profiles[indexPath.row]
        
        cell.nameLabel.text = sampleProf.profileFirstName + " " + sampleProf.profileLastName
        cell.profileImageView.image = sampleProf.profileImage
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            profiles.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            saveProfiles()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let profileDetailViewController = segue.destinationViewController as! DetailViewController
            
            // Get the cell that generated this segue.
            if let selectedProfileCell = sender as? ProfCellTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedProfileCell)!
                let selectedProfile = profiles[indexPath.row]
                profileDetailViewController.currentProfile = selectedProfile
            }
        }
        else if segue.identifier == "NewProfile" {
            
        }
    }
    
    @IBAction func unwindToProfileList(sender: AnyObject?) {
        if let sourceViewController = sender!.sourceViewController as? DetailViewController, curProfile = sourceViewController.currentProfile {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing Profile.
                profiles[selectedIndexPath.row] = curProfile
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new Profile.
                let newIndexPath = NSIndexPath(forRow: profiles.count, inSection: 0)
                profiles.append(curProfile)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            saveProfiles()
        }
    }


}
