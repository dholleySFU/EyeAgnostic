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
    var profileImage: UIImage?
    var birthDate: String
    var additionalNotes: String
    var profileScans: [ScanClass]?
    
    static let DocumentsDirectory: AnyObject = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("profiles")
    
    struct profileKey {
        static let firstKey = "firstKey"
        static let lastKey = "lastKey"
        static let imageKey = "imageKey"
        static let birthDateKey = "birthDateKey"
        static let notesKey = "notesKey"
        static let scansKey = "scansKey"
    }
    
    // MARK: Initialization
    
    init( profileFirstName: String, profileLastName: String, profileImage: UIImage?, birthDate: String, additionalNotes: String, profileScans: [ScanClass]?) {
        self.profileFirstName = profileFirstName
        self.profileLastName = profileLastName
        self.profileImage = profileImage
        self.birthDate = birthDate
        self.additionalNotes = additionalNotes
        self.profileScans = profileScans
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        var imageData: NSData?
        if profileImage != nil {
            imageData = UIImagePNGRepresentation(profileImage!)
        } else {
            imageData = nil
        }
        
        
        aCoder.encodeObject(profileFirstName, forKey: profileKey.firstKey)
        aCoder.encodeObject(profileLastName, forKey: profileKey.lastKey)
        aCoder.encodeObject(imageData, forKey: profileKey.imageKey)
        aCoder.encodeObject(birthDate, forKey: profileKey.birthDateKey)
        aCoder.encodeObject(additionalNotes, forKey: profileKey.notesKey)
        aCoder.encodeObject(profileScans, forKey: profileKey.scansKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let profileFirstName = aDecoder.decodeObjectForKey(profileKey.firstKey) as! String
        let profileLastName = aDecoder.decodeObjectForKey(profileKey.lastKey) as! String
        let profileImageData = aDecoder.decodeObjectForKey(profileKey.imageKey) as? NSData
        let birthDate = aDecoder.decodeObjectForKey(profileKey.birthDateKey) as! String
        let additionalNotes = aDecoder.decodeObjectForKey(profileKey.notesKey) as! String
        let profileScans = aDecoder.decodeObjectForKey(profileKey.scansKey) as? [ScanClass]
        
        var profileImage: UIImage?
        if profileImageData != nil {
            profileImage = UIImage(data: profileImageData!)
        } else {
            profileImage = nil
        }
        
        
        self.init( profileFirstName: profileFirstName, profileLastName: profileLastName, profileImage: profileImage, birthDate: birthDate, additionalNotes: additionalNotes, profileScans: profileScans)
        
    }

    

}
