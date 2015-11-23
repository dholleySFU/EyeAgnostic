//
//  ScanViewController.swift
//  EyeAgnostic
//
//  Created by Derek Holley on 2015-11-22.
//  Copyright © 2015 Skeye Technologies. All rights reserved.
//

import UIKit

class ScanViewController: UIViewController {
    
    var currentScan: ScanClass?
    var currentResult: Bool?
    var currentImage: UIImage?
    var viewControllerNavigatedFrom:AnyObject?
    var newScanBool: Bool?
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var reportButton: UIButton!
    
    @IBAction func myButtonPressed(sender: AnyObject) {
        if self.viewControllerNavigatedFrom!.isKindOfClass(ImagesViewController) {
            if newScanBool == true {
                //Unwind to home then to profiles list to add profile
                performSegueWithIdentifier("BackToMain", sender: self)
            } else {
                //Unwind to home then to profiles list to add profile
                performSegueWithIdentifier("BackToDetail", sender: self)
            }
        } else {
            //Unwind to view C
            performSegueWithIdentifier("BackToDetail", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentScan == nil {
            let dateFormatter:NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let DateInFormat:String = dateFormatter.stringFromDate(NSDate())
            let dateFormatter2:NSDateFormatter = NSDateFormatter()
            dateFormatter2.dateFormat = "HH:mm"
            let HourInFormat:String = dateFormatter2.stringFromDate(NSDate())
            imageView.image = currentImage
            
            currentScan = ScanClass(imageDate: DateInFormat, addImage: imageView.image, imageTime: HourInFormat, result: false)
        }
        
        imageView.image = currentScan!.addImage
        dateLabel.text = "Date: " + currentScan!.imageDate
        timeLabel.text = "Time: " + currentScan!.imageTime
        if currentScan!.result == true{
            resultLabel.text = "Result: Positive"
        } else {
            resultLabel.text = "Result: Negative"
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "BackToMain" {
            let MainView = segue.destinationViewController as! FirstViewController
            MainView.tempScan = currentScan
        }
    }
    

}
