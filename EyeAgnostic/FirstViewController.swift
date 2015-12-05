//
//  FirstViewController.swift
//  EyeAgnostic
//
//  Created by Derek Holley on 2015-11-05.
//  Copyright (c) 2015 Skeye Technologies. All rights reserved.
//  Group 1
//

import UIKit


class FirstViewController: UIViewController {
    //Simple Welcome Screen with buttons for other screens
    
    var tempScan: ScanClass?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        if tempScan != nil {
            trans()
        }
    }
    
    @IBAction func unwindToMain(sender: UIStoryboardSegue) {
    }
    
    func trans() {
        performSegueWithIdentifier("NewScanToProfile", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newImageScan" {
            let imageController = segue.destinationViewController as! ImagesViewController
            imageController.newBool = true
        }
        else if segue.identifier == "NewScanToProfile" {
            let profController = segue.destinationViewController as! ProfileTableViewController
            profController.tempScan = tempScan
            tempScan = nil
        }
    }
    
}

