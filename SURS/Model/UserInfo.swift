//
//  UserInfo.swift
//  SURS
//
//  Created by IOSUSER006 on 10/29/14.
//  Copyright (c) 2014 Dev-Touch. All rights reserved.
//

import UIKit

class UserInfo: NSObject {
    
    var username = ""
    var password = ""
    var address = ""
    var email = ""
    var mobileNumber = ""
    var fullName = ""
    var firstName = ""
    var lastName = ""
    
    func pathForUser () -> NSString{
        
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
        let userPath = path[0].stringByAppendingPathComponent(self.username)
        if NSFileManager.defaultManager().fileExistsAtPath(userPath) {
            
        }else {
            NSFileManager.defaultManager().createDirectoryAtPath(userPath, withIntermediateDirectories: true, attributes: nil, error: nil)
        }
        
        return userPath
    }
   
}
