//
//  PDFModel.swift
//  SURS
//
//  Created by IOSUSER006 on 10/14/14.
//  Copyright (c) 2014 Dev-Touch. All rights reserved.
//

import UIKit



class PDFModel: NSObject {
    
    var pdfLink:NSString = ""
    var pdfPath:NSString = ""
    var imgLink:NSString = ""
    var imgPath:NSString = ""
    var pdfTitle:NSString = ""
    var pdfDate:NSString = ""
    
    func pathForTitle (user: NSString) -> NSString{
        
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
        var userPath = path[0].stringByAppendingPathComponent(user as String)
        userPath = userPath.stringByAppendingPathComponent(self.pdfTitle as String)
        if NSFileManager.defaultManager().fileExistsAtPath(userPath) {
            
        }else {
            NSFileManager.defaultManager().createDirectoryAtPath(userPath, withIntermediateDirectories: true, attributes: nil, error: nil)
        }
        
        return userPath
    }

    

}
