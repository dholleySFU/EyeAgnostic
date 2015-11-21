//
//  Case.swift
//  EyeAgnostic
//
//  Created by Derek Holley on 2015-11-08.
//  Copyright (c) 2015 Skeye Technologies. All rights reserved.
//

import Foundation
import UIKit

class Case {
    //Class of Cases.
    
    // MARK: Properties
    
        
    var caseName: String
    var caseDate: String
    var caseImage: UIImage?
    var caseNotes: String
    var caseAdditionals: [UIImage]?
    
    // MARK: Initaliation
    
    init( caseName: String, caseDate: String, caseImage: UIImage?, caseNotes: String, caseAdditionals: [UIImage]?) {
        //Initialize Stored Properties
        self.caseName = caseName
        self.caseDate = caseDate
        self.caseImage = caseImage
        self.caseNotes = caseNotes
        self.caseAdditionals = caseAdditionals
        
    }
}