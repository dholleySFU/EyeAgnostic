//
//  ViewController.swift
//  RK
//
//  Created by Tony Lu on 2015-11-23.
//  Copyright © 2015 Tony Lu. All rights reserved.
//
import ResearchKit
import UIKit

class RKViewController: UIViewController {
    
    var res: ORKTaskResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var surveyButton: UIButton!
    @IBOutlet weak var consentButton: UIButton!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if Globals.consentBool == true {
            surveyButton.hidden = false;
            consentButton.hidden = true;
        } else {
            surveyButton.hidden = true;
            consentButton.hidden = false;
        }
    }
    
    @IBAction func consentTapped(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: ConsentTask, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }
    
    @IBAction func surveyTapped(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }
    
    func surveyReturn(result: ORKTaskResult) {
        performSegueWithIdentifier("SendSurvey", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SendSurvey" {
            let EVC = segue.destinationViewController as! EmailViewController
            EVC.recList = ["eyeagnostic@gmail.com"]
            EVC.titleText = "AyeAgnotic survey result"
        }
    }
    
    func textResultToDictionary(taskResult: ORKTaskResult, stepIdentifier: String, resultIdentifier: String, dictionaryKey: String) -> (result: String, validation: String) {
        var result : String = ""
        var validation: String = ""
        if let stepResult = taskResult.stepResultForStepIdentifier(stepIdentifier)?.resultForIdentifier(resultIdentifier) as? ORKTextQuestionResult {
            if let choice = stepResult.textAnswer {
                result = choice
            }
            else {
                validation = "* " + dictionaryKey + " was not provided.\n"
            }
        }
        return (result, validation)
    }
}

extension RKViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        //Handle results with
        //taskViewController.result
        if reason == .Completed {
            if Globals.retSource == "Consent" {
                Globals.consentBool = true
            } else if Globals.retSource == "Survey" {
                surveyReturn(taskViewController.result)
            } else {
                print("oops")
            }
        }
        taskViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}

    