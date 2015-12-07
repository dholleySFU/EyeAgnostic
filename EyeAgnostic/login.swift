//
//  Profile.swift
//  EyeAgnostic
//
//  Created by Derek Holley on 2015-11-20.
//  Copyright © 2015 Skeye Technologies. All rights reserved.
//

import Foundation
import UIKit

class login: NSObject, NSCoding {
    
    var email: String
    var pass: String
    var res: Bool
    
    static let DocumentsDirectory: AnyObject = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("login")
    
    struct loginKey {
        static let emailKey = "emailKey"
        static let passKey = "passKey"
        static let resKey = "resKey"
    }
    
    // MARK: Initialization
    
    init( email: String, pass: String, res:Bool ) {
        self.email = email
        self.pass = pass
        self.res = res
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(email, forKey: loginKey.emailKey)
        aCoder.encodeObject(pass, forKey: loginKey.passKey)
        aCoder.encodeObject(res, forKey: loginKey.resKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let email = aDecoder.decodeObjectForKey(loginKey.emailKey) as! String
        let pass = aDecoder.decodeObjectForKey(loginKey.passKey) as! String
        let res = aDecoder.decodeObjectForKey(loginKey.resKey) as! Bool

        self.init( email: email, pass: pass, res: res)
    }
}
