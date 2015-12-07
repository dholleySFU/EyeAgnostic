//
//  ChangePassViewController.swift
//  EyeAgnostic
//
//  Created by Nelson Tang on 2015-12-06.
//  Copyright © 2015 Skeye Technologies. All rights reserved.
//

import UIKit

class ChangePassViewController: UIViewController {

    @IBOutlet weak var curPass: UITextField!
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var confirm: UITextField!
    var currentPass: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func saveAction(sender: AnyObject) {
        if currentPass == nil { currentPass = "" }
        if newPass.text != "" && newPass.text == confirm.text && curPass.text == currentPass {
            performSegueWithIdentifier("unwindPass", sender: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "unwindPass" {
            let loginViewController = segue.destinationViewController as! LoginViewController
            loginViewController.returnPass = newPass.text
        }
    }
    
}
