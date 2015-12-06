//
//  EyeAlgorithm.swift
//  EyeAgnostic
//
//  Created by Shane Nilsson on 2015-12-06.
//  Copyright © 2015 Skeye Technologies. All rights reserved.
//

import Foundation
import UIKit


class EyeAlgorithm {
    
    func Analyze(image: UIImage?) -> Bool{
        let result = false
        
        let anaylizedImage:UIImage = CVWrapper.analyzeWithOpenCV(image) as UIImage
        
        return result
    }
}




