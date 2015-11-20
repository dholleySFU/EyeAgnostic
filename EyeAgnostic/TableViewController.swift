//
//  TableViewController.swift
//  EyeAgnostic
//
//  Created by Derek Holley on 2015-11-08.
//  Copyright (c) 2015 Skeye Technologies. All rights reserved.
//  Group 01
//

import UIKit

class TableViewController: UITableViewController {
    
    //Controls View+Edit table for cases
    
    // MARK: Properties
    
    var cases = [Case]()
    
    
    func loadSampleData(){
        let photo1 = UIImage(named: "Avery-Fitzgerald.jpg")!
        let sample1 = Case(caseName: "Avery Fitzgerald", caseDate: "2015-06-08", caseImage: photo1, caseNotes: "Age 10", caseAdditionals: nil)
        let photo2 = UIImage(named: "retino1.jpg")!
        let sample2 = Case(caseName: "Matthew Kelly", caseDate: "2014-05-14", caseImage: photo2, caseNotes: "Age 2", caseAdditionals: nil)
        
        cases += [sample1, sample2]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedCases = loadCases(){
            cases += savedCases
        }
        
        //Load Sample Data
        if cases.isEmpty {
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
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return cases.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "CaseTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CaseTableViewCell

        //Fetch cse for layout
        let sampleCase = cases[indexPath.row]
        
        cell.caseNameLabel.text = sampleCase.caseName
        cell.caseDateLabel.text = sampleCase.caseDate
        cell.caseImageView.image = sampleCase.caseImage

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            cases.removeAtIndex(indexPath.row)
            saveCases()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let caseDetailViewController = segue.destinationViewController as! NewCaseViewController
            
            // Get the cell that generated this segue.
            if let selectedCaseCell = sender as? CaseTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedCaseCell)!
                let selectedCase = cases[indexPath.row]
                caseDetailViewController.newCase = selectedCase
            }
        }
        else if segue.identifier == "AddItem" {
            
        }
    }
    
    @IBAction func unwindToCaseList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? NewCaseViewController, curCase = sourceViewController.newCase {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing case.
                cases[selectedIndexPath.row] = curCase
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else {
                // Add a new case.
                let newIndexPath = NSIndexPath(forRow: cases.count, inSection: 0)
                cases.append(curCase)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            saveCases()
        }
    }
    // MARK: NSCoding
    
    func saveCases() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(cases, toFile: Case.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save cases...", terminator: "")
        }
    }
    
    func loadCases() -> [Case]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Case.ArchiveURL.path!) as? [Case]
    }

}
