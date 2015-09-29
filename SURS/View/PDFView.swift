//
//  PDFView.swift
//  SURS
//
//  Created by IOSUSER006 on 10/16/14.
//  Copyright (c) 2014 Dev-Touch. All rights reserved.
//

import UIKit

class PDFView: UIView {

    
    var pdfPage: CGPDFPageRef?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        
        
    }
    
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    
    override func drawLayer(layer: CALayer!, inContext ctx: CGContext!) {
        
        
        CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0)
        
        CGContextFillRect(ctx, self.bounds)
        
        CGContextSaveGState(ctx)
        
        
        CGContextTranslateCTM(ctx, 0.0, self.bounds.size.height)
        
        CGContextScaleCTM(ctx, 1.0, -1.0)
        
        let transform:CGAffineTransform = CGPDFPageGetDrawingTransform(self.pdfPage!, kCGPDFCropBox, self.bounds, 0, false)
        CGContextConcatCTM(ctx, transform)
        CGContextDrawPDFPage(ctx, self.pdfPage)
        CGContextRestoreGState(ctx)

        
    }
    
    // MARK: - Method
    func setupPDFView(path: NSString, pageNumber: Int) {
        
        
        var urlPath: NSURL = NSURL.fileURLWithPath(path as String)!
        
        println("path of pdf \(urlPath)")
        
        var url : CFURLRef = urlPath as CFURLRef
        
        let mypath:NSString = urlPath.path!
        
        let myAllocator = kCFAllocatorDefault
        let enconding : CFStringEncoding = CFStringEncoding()
        
        let string:CFString = CFStringCreateWithCString(myAllocator, mypath.UTF8String , enconding)
        let myurl:CFURLRef = CFURLCreateWithString(myAllocator, string, url)
        
        var documentPDF = CGPDFDocumentCreateWithURL(myurl) as CGPDFDocumentRef
        
        
        self.pdfPage = CGPDFDocumentGetPage(documentPDF, UInt(pageNumber)) as! CGPDFPageRef
        

        let tileLayer = CATiledLayer()
        tileLayer.levelsOfDetail = 6
        tileLayer.levelsOfDetailBias = 5
        tileLayer.tileSize = CGSizeMake(1024, 1024)

     
    
    }
    
    
    override class func layerClass() -> AnyClass {
        return CATiledLayer.self
    }
    
   

}




