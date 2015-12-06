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

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBAction func loginAction(sender: AnyObject) {
        loginStr = loadLogin()
        if loginStr != nil {
        if passwordField.text == loginStr!.pass {
            performSegueWithIdentifier("Login", sender: self)
            }}
    }
    @IBAction func createAction(sender: AnyObject) {
        loginStr?.pass = passwordField.text!
        loginStr?.res = false
        saveLogin()
        performSegueWithIdentifier("Login", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loginStr = loadLogin() {
            createButton.enabled = false
            Globals.consentBool = loginStr.res
            loginBool = true
        } else {
            createButton.enabled = true
            loginBool = false
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if loginBool == true { createButton.enabled = false } else { createButton.enabled = true }
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
    }
    

}
