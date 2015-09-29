//
//  ImageDownloader.swift
//  SURS
//
//  Created by IOSUSER006 on 10/29/14.
//  Copyright (c) 2014 Dev-Touch. All rights reserved.
//

import UIKit

protocol ImageDownloaderDelegate {
    
    func imageDownloader (downloader: ImageDownloader, data: NSData)
    
}

class ImageDownloader: NSOperation {
    
    
    var imageURL: NSString!
    var imagePath: NSString!
    
    var delegate: ImageDownloaderDelegate?
    
    
    init(url: NSString, path: NSString) {
        self.imageURL = url
        self.imagePath = path
    }
    
    
    override func main() {
        
        autoreleasepool {
            
            if self.cancelled {
                return
            }
            
            let imageData = NSData(contentsOfURL: NSURL(string: self.imageURL! as String)!)
            

            if self.cancelled {
                return
            }
            
            imageData!.writeToFile(self.imagePath! as String, atomically: false)
            
            
            if self.cancelled {
                return
            }
            
            if NSFileManager.defaultManager().fileExistsAtPath(self.imagePath! as String) {
                self.delegate?.imageDownloader(self, data: imageData!)
            }
            
            
        }
    }
   
}
