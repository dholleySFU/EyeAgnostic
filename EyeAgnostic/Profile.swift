//
//  Profile.swift
//  EyeAgnostic
//
//  Created by Derek Holley on 2015-11-20.
//  Copyright © 2015 Skeye Technologies. All rights reserved.
//

import Foundation
import UIKit

class Profile: NSObject, NSCoding {
    
    var profileFirstName: String
    var profileLastName: String
    var birthDate: String
    var additionalNotes: String
    var profileCases: [Case]?
    
    static let DocumentsDirectory: AnyObject = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("profiles")
    
    struct profileKey {
        static let firstKey = "firstKey"
        static let lastKey = "lastKey"
        static let birthDateKey = "birthDateKey"
        static let notesKey = "notesKey"
        static let casesKey = "casesKey"
    }
    
    // MARK: Initialization
    
    init( profileFirstName: String, profileLastName: String, birthDate: String, additionalNotes: String, profileCases: [Case]?) {
        self.profileFirstName = profileFirstName
        self.profileLastName = profileLastName
        self.birthDate = birthDate
        self.additionalNotes = additionalNotes
        self.profileCases = profileCases
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(profileFirstName, forKey: profileKey.firstKey)
        aCoder.encodeObject(profileLastName, forKey: profileKey.lastKey)
        aCoder.encodeObject(birthDate, forKey: profileKey.birthDateKey)
        aCoder.encodeObject(additionalNotes, forKey: profileKey.notesKey)
        aCoder.encodeObject(profileCases, forKey: profileKey.casesKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let profileFirstName = aDecoder.decodeObjectForKey(profileKey.firstKey) as! String
        let profileLastName = aDecoder.decodeObjectForKey(profileKey.lastKey) as! String
        let birthDate = aDecoder.decodeObjectForKey(profileKey.birthDateKey) as! String
        let additionalNotes = aDecoder.decodeObjectForKey(profileKey.notesKey) as! String
        let profileCases = aDecoder.decodeObjectForKey(profileKey.casesKey) as? [Case]
        
        self.init( profileFirstName: profileFirstName, profileLastName: profileLastName, birthDate: birthDate, additionalNotes: additionalNotes, profileCases: profileCases)
        
    }

    

}
