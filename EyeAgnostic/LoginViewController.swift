//
//  LoginViewController.swift
//  EyeAgnostic
//
//  Created by Tony Lu on 2015-12-04.
//  Copyright © 2015 Skeye Technologies. All rights reserved.
//

import UIKit

struct Globals {
    static var consentBool = false
    static var retSource:String = "none"
}


class LoginViewController: UIViewController {
    
    var loginStr:login?
    var loginBool:Bool?
    var returnPass:String?

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    
    @IBAction func loginAction(sender: AnyObject) {
        if loginStr != nil {
            if passwordField.text == loginStr!.pass {
                saveLogin()
                performSegueWithIdentifier("Login", sender: self)
            }
        }
    }
    @IBAction func createAction(sender: AnyObject) {
        loginStr?.pass = passwordField.text!
        loginStr?.res = false
        saveLogin()
        performSegueWithIdentifier("Login", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tmploginStr = loadLogin() {
            createButton.enabled = false
            Globals.consentBool = tmploginStr.res
            loginBool = true
            loginStr = login(email: "", pass: tmploginStr.pass, res: tmploginStr.res)
        } else {
            createButton.enabled = true
            loginBool = false
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if loginBool == true {
            createButton.enabled = false
        } else {
            createButton.enabled = true
        }
        if returnPass != nil {
            loginStr?.pass = returnPass!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveLogin() {
        loginStr = login(email: "", pass: passwordField.text!, res: Globals.consentBool)
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(loginStr!, toFile: login.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save login.", terminator: "")
        }
    }
    
    func loadLogin() -> login? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(login.ArchiveURL.path!) as? login
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        Globals.consentBool = loginStr!.res
        if segue.identifier == "ChangePass" {
            let navVC = segue.destinationViewController as! UINavigationController
            let changeViewController = navVC.viewControllers.first as! ChangePassViewController
            changeViewController.currentPass = loginStr?.pass        }
    }
    
}
