//
//  EmailViewController.swift
//  EyeAgnostic
//
//  Created by Derek Holley on 2015-11-22.
//  Copyright © 2015 Skeye Technologies. All rights reserved.
//

import UIKit
import MessageUI

class EmailViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var recList: [String]?
    var titleText:String?
    var bodyText:String?
    var image: UIImage?
    var imageData:NSData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alert = UIAlertController(title: "Email likely to fail", message: "Email is likely to fail in XCode iOS simulator", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style:.Default, handler: nil)
        alert.addAction(ok)
        presentViewController(alert, animated: true, completion: nil)
        
        if image != nil {
            imageData = UIImagePNGRepresentation(image!)
        }
        if bodyText == nil {
            bodyText=""
        }
        
        if MFMailComposeViewController.canSendMail() {
            let toRecipents = recList
            let emailTitle = titleText
            let messageBody = bodyText
            
            let mc: MFMailComposeViewController = MFMailComposeViewController()
            mc.mailComposeDelegate = self
            mc.setToRecipients(toRecipents)
            mc.setSubject(emailTitle!)
            mc.setMessageBody(messageBody!, isHTML: false)
            if imageData != nil {
                mc.addAttachmentData(imageData!, mimeType: "image/png", fileName: "image")
            }
            
            presentViewController(mc, animated: true, completion: nil)
        } else {
            print("cannot send mails")
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result {
        case MFMailComposeResultCancelled:
            print("Mail cancelled")
        case MFMailComposeResultSaved:
            print("Mail saved")
        case MFMailComposeResultSent:
            print("Mail sent")
        case MFMailComposeResultFailed:
            print("Mail sent failure: \(error?.localizedDescription)")
        default:
            break
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}