//
//  PDFListView.swift
//  SURS
//
//  Created by IOSUSER006 on 10/14/14.
//  Copyright (c) 2014 Dev-Touch. All rights reserved.
//

/*
    Screen Resolution

    iPhone 6 Plus       736 x 414
    iPhone 6            667 x 375
    iPhone 5            568 x 320
    iPhone 4            480 x 320
*/

import UIKit


protocol PDFListViewDelegate {
    
    func pdfListViewSelected(listView: PDFListView, selected: Int)
    
}

class PDFListView: UIView , UIScrollViewDelegate , ImageDownloaderDelegate{

    var scrollMain: UIScrollView = UIScrollView()
    var arrayPDF: NSArray = NSArray()
    var arrayPDFView: NSMutableArray = NSMutableArray()
    
    var operatioMain: NSOperationQueue = NSOperationQueue()
    
    
    var delegate:PDFListViewDelegate?
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Setup
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        
    }
    
    func setupViewsForList() {
        
        self.scrollMain.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        self.scrollMain.scrollEnabled = true
        self.scrollMain.delegate = self
        //        self.scrollMain.pagingEnabled = true
        self.addSubview(self.scrollMain)
        
        
        self.operatioMain.maxConcurrentOperationCount = 1
        
        var xPosition = CGFloat(dynamicLeftPosition()) as CGFloat
        var yPosition = 0 as CGFloat
        
        var contentSize = (self.arrayPDF.count / 2)
        if self.arrayPDF.count % 2 != 0 {
            ++contentSize
        }
        
        
        self.scrollMain.contentSize = CGSizeMake(0, CGFloat(contentSize * Int(dynamicHeight())) + CGFloat(Int(dynamicYSpace()) * contentSize))
        
        
        for var count = 1; count < self.arrayPDF.count+1; count++ {
    
            let content:PDFModel = self.arrayPDF[count-1] as PDFModel
            
            var buttonContent = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            buttonContent.frame = CGRectMake(xPosition, yPosition, dynamicWidth(), dynamicHeight())
            buttonContent.tag = count
            buttonContent.setBackgroundImage(UIImage(named: "homepage_nocover"), forState: UIControlState.Normal)
            buttonContent.addTarget(self, action: "selectedItem:", forControlEvents: UIControlEvents.TouchUpInside)
            self.scrollMain.addSubview(buttonContent)
            
            if NSFileManager.defaultManager().fileExistsAtPath(content.imgPath) {
                
                buttonContent.setBackgroundImage(UIImage(contentsOfFile: content.imgPath), forState: UIControlState.Normal)
                
            }else {
                
                let downloader = ImageDownloader(url: content.imgLink, path: content.imgPath)
                downloader.delegate = self
                downloader.name = "\(count)"
                self.operatioMain.addOperation(downloader)
                
            }
            
            xPosition = xPosition + CGFloat(dynamicLeftPosition()) + dynamicWidth()
            
            if count % 2 == 0 {
                xPosition = CGFloat(dynamicLeftPosition())
                yPosition = yPosition + dynamicHeight() + dynamicYSpace()
            }
            
        }
        
    }
    
    // MARK: - Functions
    
    func dynamicLeftPosition() -> Int {
        // iPhone 4 and iPhone 5
        var returnValue:Int = Int(UIScreen.mainScreen().bounds.width) as Int
        
        returnValue = returnValue - (Int(dynamicWidth())*2)
        returnValue = returnValue/3
        
        return returnValue
    }
    
    func dynamicWidth() -> CGFloat {
        // iPhone 4 and iPhone 5
        var returnValue:CGFloat = 130 as CGFloat
        // iPhone 6
        if UIScreen.mainScreen().bounds.width == 375 {
            returnValue = 152
        }
            // 4
        else if UIScreen.mainScreen().bounds.width == 414 {
            returnValue = 168
        }
        
        return returnValue
        
    }
    
    func dynamicHeight() -> CGFloat {
        // iPhone 4
        var returnValue:CGFloat = 152 as CGFloat
        
        if UIScreen.mainScreen().bounds.height == 568 {
            returnValue = 180
        }
            
        else if UIScreen.mainScreen().bounds.height == 667 {
            returnValue = 211
        }
            
        else if UIScreen.mainScreen().bounds.height == 736 {
            returnValue = 233
        }
        
        return returnValue
    }
    
    func dynamicYSpace() -> CGFloat {
        // iPhone 4
        var returnValue:CGFloat = 30 as CGFloat
        
        if UIScreen.mainScreen().bounds.height == 568 {
            returnValue = 30
        }
            
        if UIScreen.mainScreen().bounds.height == 667 {
            returnValue = 40
        }
            
        else if UIScreen.mainScreen().bounds.height == 736 {
            returnValue = 50
        }
        
        return returnValue
    }
    
    func selectedItem (selected: UIButton) {
        
        println("Selected Item = \(selected.tag)")
        self.delegate?.pdfListViewSelected(self, selected: selected.tag)
        
        
    }
    
    // MARK: - Delegate
    // MARK: ScrollView
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        
        
    }
    
    func imageDownloader(downloader: ImageDownloader, data: NSData) {
        
        for (index, object) in enumerate(self.scrollMain.subviews) {
            
            if object.isKindOfClass(UIButton) {
                var button = object as UIButton
                if "\(button.tag)" == downloader.name {
                    
                    let pdfContet = self.arrayPDF[button.tag-1] as PDFModel
                    button.setBackgroundImage(UIImage(contentsOfFile: pdfContet.imgPath), forState: UIControlState.Normal)
                    
                    
                }
            }
            
        }
        
    }
    

}
