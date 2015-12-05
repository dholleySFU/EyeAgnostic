//
//  EmailPrepViewController.swift
//  EyeAgnostic
//
//  Created by Tony Lu on 2015-12-04.
//  Copyright © 2015 Skeye Technologies. All rights reserved.
//

import UIKit

class EmailPrepViewController: UIViewController {
    
    var image:UIImage?
    var recList: [String]?
    var titleText: String?
    var bodyText: String?

    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var subjectField: UITextField!
    @IBOutlet weak var bodyField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if recList != nil {addressField.text = recList![0]} else { recList = [] }
        subjectField.text = titleText
        bodyField.text = bodyText
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CaseSend" {
            let MainView = segue.destinationViewController as! EmailViewController
            MainView.recList = recList
            MainView.titleText = titleText
            MainView.bodyText = bodyText
            MainView.image = image
        }
    }
    
    @IBAction func sendCase(){
        if addressField.text != "" && subjectField.text != "" {
            recList! = [addressField.text!]
            titleText = subjectField.text
            bodyText = bodyField.text
        
            performSegueWithIdentifier("CaseSend", sender: self)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
