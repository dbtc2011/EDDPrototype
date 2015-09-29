//
//  PDFPSplitListView.swift
//  SURS
//
//  Created by IOSUSER006 on 10/17/14.
//  Copyright (c) 2014 Dev-Touch. All rights reserved.
//

import UIKit

protocol PDFSplitListViewDelegate {
    
    func pdfSplitListView (splitView: PDFPSplitListView, selected: Int)
    
}
    

class PDFPSplitListView: UIView, UIScrollViewDelegate {
    
    var arrayPages = NSMutableArray()
    var selectedPage = 1
    var totalPage:Int?
    var pdfPath:NSString?
    
    var delegate: PDFSplitListViewDelegate?
    
    // MARK: - Method
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
//        self.backgroundColor = UIColor(red: 90/255, green: 154/255, blue: 230/255, alpha: 1)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPages(selected: Int, totalPage: Int, pdfPath: NSString) {
        
        self.selectedPage = selected
        self.totalPage = totalPage
        self.pdfPath = pdfPath
        
        let imageView = UIImageView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        imageView.image = UIImage(named: "pagelist_slider")
        self.addSubview(imageView)
        
        
        if self.totalPage != 0 {
            
            var contentSizeScroll = (80 * (self.totalPage!)) + (15 * (self.totalPage!-1)) + 5
            
            let scrollView = UIScrollView(frame: CGRectMake(5, 40, self.frame.size.width - 10, self.frame.size.height))
            scrollView.delegate = self
            scrollView.scrollEnabled = true
            scrollView.backgroundColor = UIColor.clearColor()
            scrollView.contentSize = CGSizeMake(CGFloat(contentSizeScroll), 0)
            self.addSubview(scrollView)
            

            var xPosition = 0 as CGFloat
            
        
            for var count = 1; count <= self.totalPage; count++ {
                
                let pdfViewScroll = PDFView(frame: CGRectMake(xPosition, 5, 80, 100)) as PDFView
                pdfViewScroll.setupPDFView(self.pdfPath!, pageNumber: count)
                scrollView.addSubview(pdfViewScroll)
                
                let button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
                button.frame = CGRectMake(0, 0, 80, 100)
                button.tag = count
                button.addTarget(self, action: "buttonSelected:", forControlEvents: .TouchUpInside)
                pdfViewScroll.addSubview(button)
                
                let label = UILabel(frame: CGRectMake((80/2)-(30/2), (100/2)-(30/2), 30, 30))
                label.text = "\(count)"
                label.textAlignment = NSTextAlignment.Center
                label.layer.cornerRadius = 15
                label.layer.masksToBounds = true
                label.textColor = UIColor.whiteColor()
                label.alpha = 0.7
                label.backgroundColor = UIColor.blackColor()
                button.addSubview(label)
                
                xPosition = xPosition + 15 + 80
            }
            
            self.setNeedsDisplay()

        }
        
        
    }

    // MARK: - Functio
    func buttonSelected (sender: UIButton) {
        
        self.delegate?.pdfSplitListView(self, selected: sender.tag)
        
    }
    
    // MARK: - Delegate
    // MARK: ScrollView
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}
