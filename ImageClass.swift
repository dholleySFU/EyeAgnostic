//
//  ImageClass.swift
//  EyeAgnostic
//
//  Created by Derek Holley on 2015-11-20.
//  Copyright © 2015 Skeye Technologies. All rights reserved.
//

import Foundation
import UIKit

class ImageClass {
    var addImage: UIImage?
    var imageDate: String
    
    init( imageDate: String, addImage: UIImage? ) {
        //Initialize Stored Properties
        self.imageDate = imageDate
        self.addImage = addImage
    }

}