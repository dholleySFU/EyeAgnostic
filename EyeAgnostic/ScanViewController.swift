//
//  ScanViewController.swift
//  EyeAgnostic
//
//  Created by Derek Holley on 2015-11-22.
//  Copyright © 2015 Skeye Technologies. All rights reserved.
//

import UIKit
import SwiftyDropbox

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
        
        uploadToDropbox()
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
        if segue.identifier == "ToEmail" {
            let MainView = segue.destinationViewController as! EmailPrepViewController
            MainView.titleText = "Retinoblastoma detected by EyeAgnostic Software"
            MainView.image = imageView.image
        }
    }
    
    
    func uploadToDropbox(){
        let localAddress = saveToDevice()
        //if (Dropbox.authorizedClient != nil) {
        //    DropboxClient.sharedClient.files.upload(path: "", body: localAddress)
        // }
 
        
        // Verify user is logged into Dropbox
        if let client = Dropbox.authorizedClient {
            
            // Get the current user's account info
            client.users.getCurrentAccount().response { response, error in
                print("*** Get current account ***")
                if let account = response {
                    print("Hello \(account.name.givenName)!")
                } else {
                    print(error!)
                }
            }
            
            // List folder
            client.files.listFolder(path: "").response { response, error in
                print("*** List folder ***")
                if let result = response {
                    print("Folder contents:")
                    for entry in result.entries {
                        print(entry.name)
                    }
                } else {
                    print(error!)
                }
            }
            
            // Upload a file
          //  let fileData = "Hello!".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
          //  client.files.upload(path: "/hello.txt", body: fileData!).response { response, error in
           
            DropboxClient.sharedClient.files.upload(path: "/" + currentScan!.imageDate + "_" + currentScan!.result.description + ".png", body: localAddress).response { response, error in

            
                if let metadata = response {
                    print("*** Upload file ****")
                    print("Uploaded file name: \(metadata.name)")
                    print("Uploaded file revision: \(metadata.rev)")
                    
                } else {
                    print(error!)
                }
            }
        }
        
    
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func saveToDevice() -> NSURL{
        if let data = UIImageJPEGRepresentation(imageView.image!, 0.8) {
            let filename = getDocumentsDirectory().stringByAppendingPathComponent(currentScan!.imageDate + "_" + currentScan!.result.description + ".png")
            data.writeToFile(filename, atomically: true)
        }
        let localAddress = NSURL(string: getDocumentsDirectory().stringByAppendingPathComponent(currentScan!.imageDate + "_" + currentScan!.result.description + ".png"))
        return localAddress!
    }
    

}
