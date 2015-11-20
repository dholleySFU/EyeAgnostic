//
//  Case.swift
//  EyeAgnostic
//
//  Created by Derek Holley on 2015-11-08.
//  Copyright (c) 2015 Skeye Technologies. All rights reserved.
//

import Foundation
import UIKit

class Case: NSObject, NSCoding {
    //Class of Cases.
    
    // MARK: Properties
    
    static let DocumentsDirectory: AnyObject = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("cases")
    
    var caseName: String
    var caseDate: String
    var caseImage: UIImage?
    var caseNotes: String
    var caseAdditionals: [UIImage]?
    
    // MARK: Types
    
    struct CaseKey {
        static let nameKey = "caseName"
        static let dateKey = "caseDate"
        static let noteKey = "caseNotes"
        static let imageKey = "caseImage"
        static let additionalsKey = "caseAdditionals"
    }
    
    // MARK: Initaliation
    
    init( caseName: String, caseDate: String, caseImage: UIImage?, caseNotes: String, caseAdditionals: [UIImage]?) {
        //Initialize Stored Properties
        self.caseName = caseName
        self.caseDate = caseDate
        self.caseImage = caseImage
        self.caseNotes = caseNotes
        self.caseAdditionals = caseAdditionals
        
        super.init()
        
        // Initialization should fail if no name is assigned
        //if caseName.isEmpty {
        //    return nil
        //}
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(caseName, forKey: CaseKey.nameKey)
        aCoder.encodeObject(caseDate, forKey: CaseKey.dateKey)
        aCoder.encodeObject(caseNotes, forKey: CaseKey.noteKey)
        aCoder.encodeObject(caseImage, forKey: CaseKey.imageKey)
        aCoder.encodeObject(caseAdditionals, forKey: CaseKey.additionalsKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let caseName = aDecoder.decodeObjectForKey(CaseKey.nameKey) as! String
        let caseDate = aDecoder.decodeObjectForKey(CaseKey.dateKey) as! String
        let caseNotes = aDecoder.decodeObjectForKey(CaseKey.noteKey) as! String
        let caseImage = aDecoder.decodeObjectForKey(CaseKey.imageKey) as? UIImage
        let caseAdditionals = aDecoder.decodeObjectForKey(CaseKey.additionalsKey) as? [UIImage]
        
        self.init(caseName: caseName, caseDate: caseDate, caseImage: caseImage, caseNotes: caseNotes, caseAdditionals: caseAdditionals)
        
    }
}