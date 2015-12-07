//
//  ScanClass.swift
//  EyeAgnostic
//
//  Created by Derek Holley on 2015-11-21.
//  Copyright © 2015 Skeye Technologies. All rights reserved.
//

import Foundation
import UIKit

class ScanClass: NSObject, NSCoding {
    var addImage: UIImage?
    var imageDate: String
    var imageTime: String
    var result: Bool
    
    init( imageDate: String, addImage: UIImage?, imageTime: String, result: Bool) {
        //Initialize Stored Properties
        self.imageDate = imageDate
        self.addImage = addImage
        self.imageTime = imageTime
        self.result = result
    }
    
    struct profileKey {
        static let imageKey = "imageKey"
        static let dateKey = "dateKey"
        static let timeKey = "timeKey"
        static let resultKey = "resultKey"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let imageData = aDecoder.decodeObjectForKey(profileKey.imageKey) as? NSData
        let imageDate = aDecoder.decodeObjectForKey(profileKey.dateKey) as! String
        let imageTime = aDecoder.decodeObjectForKey(profileKey.timeKey) as! String
        let result = aDecoder.decodeObjectForKey(profileKey.resultKey) as! Bool
        
        var addImage: UIImage?
        if imageData != nil {
            addImage = UIImage(data: imageData!)
        } else {
            addImage = nil
        }
        
        self.init( imageDate: imageDate, addImage: addImage, imageTime: imageTime, result: result)
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        var imageData: NSData?
        if addImage != nil {
            imageData = UIImagePNGRepresentation(addImage!)
        } else {
            imageData = nil
        }
        
        aCoder.encodeObject(imageData, forKey: profileKey.imageKey)
        aCoder.encodeObject(imageDate, forKey: profileKey.dateKey)
        aCoder.encodeObject(imageTime, forKey: profileKey.timeKey)
        aCoder.encodeObject(result, forKey: profileKey.resultKey)
    }
}