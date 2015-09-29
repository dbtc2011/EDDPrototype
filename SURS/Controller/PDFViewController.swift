//
//  PDFViewController.swift
//  SURS
//
//  Created by IOSUSER006 on 10/16/14.
//  Copyright (c) 2014 Dev-Touch. All rights reserved.
//

import UIKit

class PDFViewController: UIViewController, UIGestureRecognizerDelegate, UIScrollViewDelegate , PDFSplitListViewDelegate, ArticleControllerDelegate , ZoningParserDelegate{

    @IBOutlet var buttonSlider: UIButton!
    
    var filePathPDF:NSString!
    var totalPageNumber:Int?
    
    var pt = CGPoint(x: 0, y: 0)
    var oldLocation = CGPoint(x: 0, y: 0)
    var newLocation = CGPoint(x: 0, y: 0)
    
    
    var arrayPages = [] as NSMutableArray
    
    var user: UserInfo?
    var pdfRepresentation: PDFModel?
    
    var currentPage = 1
    var slider = PDFPSplitListView(frame: CGRectMake(0, 568, 320, 120))
    var isAnimating = false
    var isSliderShown = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseZoning()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.navigationItem.hidesBackButton = true
        
        self.buttonSlider.addTarget(self, action: "aniateSlider", forControlEvents: .TouchUpInside)
        var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "panGesture:")
        panGestureRecognizer.delegate = self
        panGestureRecognizer.maximumNumberOfTouches = 1
        self.view.addGestureRecognizer(panGestureRecognizer)
        
//        var tapGesture = UITapGestureRecognizer(target: self, action: "tapGestureRecognizer:")
//        tapGesture.numberOfTouchesRequired = 1
//        tapGesture.delegate = self
//        self.view.addGestureRecognizer(tapGesture)
        

        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    
//        reloadPDFView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
//        var pdfPath: NSString = NSBundle.mainBundle().pathForResource("sample", ofType: "pdf")!
//        self.filePathPDF = pdfPath as NSString
        self.filePathPDF = self.pdfRepresentation!.pdfPath
        self.filePathPDF = self.filePathPDF.stringByAppendingPathComponent("\(self.pdfRepresentation!.pdfTitle).pdf")
        self.totalPageNumber = getTotalNumberOfPages() as Int
        
        
        

        self.slider.frame = CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 150)
        self.slider.delegate = self
        self.slider.setupPages(0, totalPage: self.totalPageNumber!, pdfPath: self.filePathPDF!)
        
        self.view.addSubview(self.slider)
        self.view.bringSubviewToFront(self.buttonSlider)
        
    
    }
    
    
    
    // MARK: - Setup
    func setupScrollView (scrollTag: Int, pdfPage: Int) -> UIScrollView {
        
        var xPosition = 0
        if scrollTag == 1 {
            xPosition = -1
        }
        
        xPosition = xPosition * Int(self.view.frame.size.width)
        var scroll = UIScrollView(frame: CGRectMake(CGFloat(xPosition), 64, self.view.frame.size.width, self.view.frame.size.height-64))
        scroll.tag = scrollTag
        scroll.maximumZoomScale = 3.0
        scroll.minimumZoomScale = 1.0
        scroll.zoomScale = 1.0
        scroll.userInteractionEnabled = true
        scroll.delegate = self
        
        var pdfPages = PDFView(frame: CGRectMake(0, 0, scroll.frame.width, scroll.frame.height))
        pdfPages.setupPDFView(self.filePathPDF!, pageNumber: pdfPage)
        scroll.addSubview(pdfPages)
        
        
        let btn = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        btn.frame = CGRectMake(0, 0, 100, 100)
        btn.backgroundColor = UIColor.clearColor()
        btn.addTarget(self, action: "temporaryButtonForArticle:", forControlEvents: .TouchUpInside)
        pdfPages.addSubview(btn)
        
        let arrayOfZoning = getZoningContentsOfPage(pdfPage)
        
        if arrayOfZoning != nil {
            let dictionaryZoning = arrayOfZoning?.lastObject as! NSDictionary
            let arrayContentss = dictionaryZoning["content"] as! NSArray
            
            if  arrayContentss.count != 0 {
                setupEnhancement(arrayContentss, pageView: pdfPages)
            }
    
            
        }
    
        return scroll
        
    }
    
    func setupEnhancement(contents: NSArray, pageView: PDFView) {
        
        for (index, dictionary) in enumerate(contents) {
            
            if dictionary.isKindOfClass(NSDictionary) {
                
                let dictionaryContent = dictionary as! NSDictionary
                
                let button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
                button.backgroundColor = UIColor.grayColor()
                button.alpha = 0.3
                button.frame = CGRectMake(getXZoning(dictionaryContent["left"] as! NSString, imageWidth: "794"), getYZoning(dictionaryContent["top"] as! NSString, imageHeight: "1123"), getWidthZoning(dictionaryContent["width"] as! NSString, imageWidth: "794"), getHeightZoning(dictionaryContent["height"] as! NSString, imageHeight: "1123"))
                pageView.addSubview(button)
                
            }
            
        }
        
        
    }
    
    func reloadPDFView (){
        
        if getScrollView(1) != nil{
            
            getScrollView(1)!.removeFromSuperview()
            
        }
        
        if getScrollView(2) != nil{
            
            getScrollView(2)!.removeFromSuperview()
            
        }
        
        if getScrollView(3) != nil{
            
            getScrollView(3)!.removeFromSuperview()
            
        }
        
        if self.currentPage == 1 {
            self.view.addSubview(setupScrollView(3, pdfPage: self.currentPage+1))
            self.view.addSubview(setupScrollView(2, pdfPage: self.currentPage))
        }else if self.currentPage == self.totalPageNumber {
            self.view.addSubview(setupScrollView(2, pdfPage: self.currentPage))
            self.view.addSubview(setupScrollView(1, pdfPage: self.currentPage-1))
        }else {
            self.view.addSubview(setupScrollView(3, pdfPage: self.currentPage+1))
            self.view.addSubview(setupScrollView(2, pdfPage: self.currentPage))
            self.view.addSubview(setupScrollView(1, pdfPage: self.currentPage-1))
        }
        
        if self.isSliderShown {
            if !self.isAnimating {
                self.isAnimating = !self.isAnimating
                
                var yPosition = self.view.frame.size.height - 40
                
                if yPosition == self.slider.frame.origin.y {
                    yPosition = self.slider.frame.origin.y - 110
                }
                
                UIView.animateKeyframesWithDuration(0.3, delay: 0, options: nil, animations: {
                    self.slider.frame = CGRectMake(0, yPosition, self.view.frame.size.width, self.slider.frame.size.height)
                    self.buttonSlider.frame = CGRectMake(self.buttonSlider.frame.origin.x, yPosition, self.buttonSlider.frame.size.width, self.buttonSlider.frame.height)
                    }, completion: { finished in
                        self.isAnimating = !self.isAnimating
                        self.isSliderShown = !self.isSliderShown
                })
            }
        }
        
        
        self.view.bringSubviewToFront(self.slider)
        self.view.bringSubviewToFront(self.buttonSlider)
        
    }
    
    // MARK: - Function
    func getScrollView (tag: Int) -> UIScrollView? {
        
        var scroll: UIScrollView?
        
        for (index, subviews) in enumerate(self.view.subviews) {
            if subviews.isKindOfClass(UIScrollView) {
                let scrollHolder = subviews as! UIScrollView
                if tag == scrollHolder.tag {
                    return scrollHolder
                    
                }
                scroll = nil
            }
        }
        
        return scroll
        
    }
    
    func getTotalNumberOfPages () -> Int {
        
        var urlPath: NSURL = NSURL.fileURLWithPath(self.filePathPDF! as String)!
        println("URLPath = \(urlPath)")
        
        var url : CFURLRef = urlPath as CFURLRef
        
        let mypath:NSString = urlPath.path!
        
        let myAllocator = kCFAllocatorDefault
        let enconding : CFStringEncoding = CFStringEncoding()
        
        let string:CFString = CFStringCreateWithCString(myAllocator, mypath.UTF8String , enconding)
        let myurl:CFURLRef = CFURLCreateWithString(myAllocator, string, url)
        
        var documentPDF = CGPDFDocumentCreateWithURL(myurl) as CGPDFDocumentRef
        
        return Int(CGPDFDocumentGetNumberOfPages(documentPDF))
    }
    
    func temporaryButtonForArticle(sender: UIButton) {
        
        self.performSegueWithIdentifier("toArticleView", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let controller = segue.destinationViewController as! ArticleController
        controller.totalPageNumber = self.totalPageNumber
        controller.delegate = self
        controller.filePathPDF = self.filePathPDF
        controller.user = self.user
        controller.pdfRepresentation = self.pdfRepresentation
        controller.arrayEnhancement = self.arrayPages
    }

    
    
    func panGesture(recognizer: UIPanGestureRecognizer) {
        
        
        
        if !self.isSliderShown {
            
            if recognizer.state == UIGestureRecognizerState.Began {
                
                self.pt = recognizer.locationInView(self.view)
                self.newLocation = self.pt
                
            }else if recognizer.state == UIGestureRecognizerState.Changed {
                
                self.oldLocation = self.newLocation
                self.newLocation = recognizer.locationInView(self.view)
                
                
                if getScrollView(1) != nil && CGRectGetMinX(getScrollView(1)!.frame) + self.newLocation.x - self.oldLocation.x > -self.view.frame.size.width && CGRectGetMinX(getScrollView(2)!.frame) >= 0{
                    
                    getScrollView(1)!.frame = CGRectMake(CGRectGetMinX(getScrollView(1)!.frame) + (self.newLocation.x - self.oldLocation.x), CGRectGetMinY(getScrollView(1)!.frame), CGRectGetWidth(getScrollView(1)!.frame), CGRectGetHeight(getScrollView(1)!.frame))
                    
                    if CGRectGetMinX(getScrollView(2)!.frame) > 0 {
                        getScrollView(2)!.frame = CGRectMake(0, CGRectGetMinY(getScrollView(2)!.frame), CGRectGetWidth(getScrollView(2)!.frame), CGRectGetHeight(getScrollView(2)!.frame))
                    }
                    
                }else if getScrollView(1) == nil && CGRectGetMinX(getScrollView(2)!.frame) + (self.newLocation.x - self.oldLocation.x) > 0 {
                    
                    //do not move right if current page is equal to first page
                    
                }else if getScrollView(3) == nil && CGRectGetMinX(getScrollView(2)!.frame) + (self.newLocation.x - self.oldLocation.x) < 0 {
                    
                    //do not move right if current page is equal to first page
                    
                }else {
                    
                    //move current page
                    
                    getScrollView(2)!.frame = CGRectMake(CGRectGetMinX(getScrollView(2)!.frame)+(self.newLocation.x - self.oldLocation.x) , CGRectGetMinY(getScrollView(2)!.frame), CGRectGetWidth(getScrollView(2)!.frame), CGRectGetHeight(getScrollView(2)!.frame))
                    
                    if CGRectGetMinX(getScrollView(2)!.frame) > -self.view.frame.size.width {
                        
                    }
                    
                }
                
            }else if recognizer.state == UIGestureRecognizerState.Ended {
                let trigger = (self.view.frame.size.width/2) - 40
                
                if getScrollView(2)!.frame.origin.x > -trigger && getScrollView(2)!.frame.origin.x < 0{
                    
                    UIView.animateKeyframesWithDuration(0.3, delay: 0, options: nil, animations: {
                        
                        self.getScrollView(2)!.frame = CGRectMake(0, self.getScrollView(2)!.frame.origin.y, self.getScrollView(2)!.frame.size.width, self.getScrollView(2)!.frame.size.height)
                        
                        }, completion: { finished in
                            //                        self.isAnimating = !self.isAnimating
                    })
                    
                }else if getScrollView(2)!.frame.origin.x <= -trigger{
                    UIView.animateKeyframesWithDuration(0.3, delay: 0, options: nil, animations: {
                        
                        self.getScrollView(2)!.frame = CGRectMake(-self.getScrollView(2)!.frame.size.width, self.getScrollView(2)!.frame.origin.y, self.getScrollView(2)!.frame.size.width, self.getScrollView(2)!.frame.size.height)
                        
                        }, completion: { finished in
                            //                        self.isAnimating = !self.isAnimating
                            if self.currentPage >= self.totalPageNumber {
                                
                            }else {
                                
                                if self.getScrollView(1) != nil {
                                    self.getScrollView(1)!.removeFromSuperview()
                                }
                                self.getScrollView(2)!.tag = 1
                                self.getScrollView(3)!.tag = 2
                                
                                if self.currentPage >= self.totalPageNumber!-1 {
                                    
                                }else {
                                    
                                    self.view.addSubview(self.setupScrollView(3, pdfPage: self.currentPage+2))
                                }
                                
                                self.currentPage = self.currentPage + 1
                                
                                self.view.bringSubviewToFront(self.getScrollView(2)!)
                                
                                self.view.bringSubviewToFront(self.getScrollView(1)!)
                                
                                self.view.bringSubviewToFront(self.slider)
                                self.view.bringSubviewToFront(self.buttonSlider)
                            }
                    })
                }else if getScrollView(1) != nil && getScrollView(1)!.frame.origin.x < 0 && getScrollView(1)!.frame.origin.x > -(self.view.frame.size.width/2){
                    UIView.animateKeyframesWithDuration(0.3, delay: 0, options: nil, animations: {
                        
                        self.getScrollView(1)!.frame = CGRectMake(0, self.getScrollView(1)!.frame.origin.y, self.getScrollView(1)!.frame.size.width, self.getScrollView(1)!.frame.size.height)
                        
                        }, completion: { finished in
                            
                            if self.currentPage == 1 {
                                
                            }else {
                                if self.getScrollView(3) != nil {
                                    self.getScrollView(3)!.removeFromSuperview()
                                    
                                }
                                self.getScrollView(2)!.tag = 3
                                self.getScrollView(1)!.tag = 2
                                
                                
                                self.view.bringSubviewToFront(self.getScrollView(2)!)
                                
                                if self.currentPage == 2 {
                                    
                                }else {
                                    self.view.addSubview(self.setupScrollView(1, pdfPage: self.currentPage-2))
                                }
                                
                                self.view.bringSubviewToFront(self.slider)
                                self.view.bringSubviewToFront(self.buttonSlider)
                                
                            }
                            
                            self.currentPage = self.currentPage - 1
                            
                    })
                }else if getScrollView(1) != nil && getScrollView(1)!.frame.origin.x <= -(self.view.frame.size.width/2) && getScrollView(1)!.frame.origin.x >= -self.view.frame.size.width {
                    
                    UIView.animateKeyframesWithDuration(0.3, delay: 0, options: nil, animations: {
                        
                        self.getScrollView(1)!.frame = CGRectMake(-self.view.frame.size.width, self.getScrollView(1)!.frame.origin.y, self.getScrollView(1)!.frame.size.width, self.getScrollView(1)!.frame.size.height)
                        
                        }, completion: { finished in
                            
                    })
                    
                }
                

            }
            
        }
        
    }
    
    
    func tapGestureRecognizer(recognizer: UISwipeGestureRecognizer) {
        self.view.bringSubviewToFront(self.slider)
        
        if !self.isAnimating {
            self.isAnimating = !self.isAnimating
            
            var yPosition = self.view.frame.size.height - 40
            
            if yPosition == self.slider.frame.origin.y {
                yPosition = self.slider.frame.origin.y - 110
            }
            
            UIView.animateKeyframesWithDuration(0.3, delay: 0, options: nil, animations: {
                self.slider.frame = CGRectMake(0, yPosition, self.view.frame.size.width, self.slider.frame.size.height)
                }, completion: { finished in
                    self.isAnimating = !self.isAnimating
                    self.isSliderShown = !self.isSliderShown
            })
        }
        
        
    }
    
    func aniateSlider() {
        
        
        if !self.isAnimating {
            self.isAnimating = !self.isAnimating
            
            var yPosition = self.view.frame.size.height - 40
            
            if yPosition == self.slider.frame.origin.y {
                yPosition = self.slider.frame.origin.y - 110
            }
            
            UIView.animateKeyframesWithDuration(0.3, delay: 0, options: nil, animations: {
                
                self.slider.frame = CGRectMake(0, yPosition, self.view.frame.size.width, self.slider.frame.height)
                self.buttonSlider.frame = CGRectMake(self.buttonSlider.frame.origin.x, yPosition, self.buttonSlider.frame.size.width, self.buttonSlider.frame.height)
                
                }, completion: { finished in
                    self.isAnimating = !self.isAnimating
                    self.isSliderShown = !self.isSliderShown
                    
            })
            
            
        }
        
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return false
    
    }
    
    // Test For Parsing
    func parseZoning() {
        
        let string = NSBundle.mainBundle().pathForResource("1stpage", ofType: "xml")
        
        let xmlParser = ZoningXMLParser() as ZoningXMLParser
        xmlParser.delegate = self
        xmlParser.parseXML(string!)
        
    }
    
    func getZoningContentsOfPage (page: Int) -> NSArray? {
        
        let predicate = NSPredicate(format: "page == 'Page\(page)'", argumentArray: nil)
        
        var arrayFilter = self.arrayPages.filteredArrayUsingPredicate(predicate)
        
        if arrayFilter.count != 0 {
            return arrayFilter
        }


        return nil
    }
    
    func getXZoning (value: NSString, imageWidth: NSString) -> CGFloat{
        
        var value = (value.floatValue * Float(self.view.frame.size.width)) / imageWidth.floatValue
        

    
        return CGFloat(value)
        
    }
    
    func getYZoning (value: NSString, imageHeight: NSString) -> CGFloat{
        
        var value = (value.floatValue * Float(self.view.frame.size.height-64)) / imageHeight.floatValue
      
        return CGFloat(value)
        
    }
    
    func getWidthZoning (value: NSString, imageWidth: NSString) -> CGFloat{
        
        var value = (value.floatValue * Float(self.view.frame.size.width)) / imageWidth.floatValue
        
        return CGFloat(value)
        
    }
    
    func getHeightZoning (value: NSString, imageHeight: NSString) -> CGFloat{
        
        var value = (value.floatValue * Float(self.view.frame.size.height-64)) / imageHeight.floatValue
        
        return CGFloat(value)
        
    }
    
    
    // MARK: - Delegate
    // MARK: SplitListView
    
    func pdfSplitListView(splitView: PDFPSplitListView, selected: Int) {
        
        self.currentPage = selected
        reloadPDFView()
        
    }
    
    // MARK: ArticleController
    
    func articleControllerSelected(artcile: ArticleController, selected: Int) {
        self.currentPage = selected
        reloadPDFView()
        
    }
    
    func zoningParser(parser: ZoningXMLParser, contents: NSMutableArray) {
        println("MAG ADD SUBVIEW KA!!!!\n\(contents)")
        self.arrayPages.removeAllObjects()
        self.arrayPages.addObjectsFromArray(contents as [AnyObject])
        
        dispatch_async(dispatch_get_main_queue(), {
            if self.totalPageNumber > 1 {
                
                self.view.addSubview(self.setupScrollView(3, pdfPage: 2))
                
            }
            
            if self.totalPageNumber > 0 {
                
                self.view.addSubview(self.setupScrollView(2, pdfPage: 1))
                
            }
            self.view.bringSubviewToFront(self.slider)
            self.view.bringSubviewToFront(self.buttonSlider)
        })
    
    
        
        
    }
    
    func zoningParserFailed(parser: ZoningXMLParser) {


    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        let view = scrollView.subviews[0] as! UIView
        return view
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



