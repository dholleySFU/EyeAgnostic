import UIKit
import SwiftyDropbox

class DropboxViewController: UIViewController {
 
    //Button for linking dropbox account
    @IBOutlet weak var loginButton: UIButton!
    
    //Button for disconnecting dropbox account
    @IBOutlet weak var logoutButton: UIButton!
    
    
    override func viewDidLoad() {
        disableButtons()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonPress(sender: AnyObject) {
        if (Dropbox.authorizedClient == nil) {
            Dropbox.authorizeFromController(self)
        } else {
            print("User is already authorized!")
        }
        disableButtons()
        
    }
    
    @IBAction func logoutButtonPress(sender: AnyObject) {
        // Unlink from Dropbox
        Dropbox.unlinkClient()
        disableButtons()
        
    }
    
    
    func disableButtons(){
        if (Dropbox.authorizedClient == nil) {
            loginButton.enabled = true;
            logoutButton.enabled = false;
            
            loginButton.hidden = false;
            logoutButton.hidden = true;
        } else {
            loginButton.enabled = false;
            logoutButton.enabled = true;
            
            loginButton.hidden = true;
            logoutButton.hidden = false;
        }
    }

    
}