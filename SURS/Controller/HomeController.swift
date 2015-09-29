//
//  HomeController.swift
//  SURS
//
//  Created by IOSUSER006 on 10/14/14.
//  Copyright (c) 2014 Dev-Touch. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UIScrollViewDelegate, PDFListViewDelegate{

    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var scrollBanner: UIScrollView!
    @IBOutlet var imgPictureDescription: UIImageView!
    

    
    var user: UserInfo?
    
    var selectedIndex = 0
    
    var pdfListView: PDFListView = PDFListView(frame: CGRectMake(0, 310, 320, 258))
    var arrayPDFList: NSMutableArray = NSMutableArray()
    var arrayBanner: NSMutableArray = [] as NSMutableArray
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(true)
        let navigationController: SURSNavigationController = self.navigationController as! SURSNavigationController
        
        self.arrayPDFList = navigationController.arrayPDF
        self.user = navigationController.user
        self.view.backgroundColor = UIColor.whiteColor()
        
        var yPosition = 310 as CGFloat
        
        
        if UIScreen.mainScreen().bounds.height == 480 {
            yPosition = 270
        }else if UIScreen.mainScreen().bounds.height == 667 {
            yPosition = 330
        }
        
        
        self.pdfListView.frame = CGRectMake(0, yPosition, self.view.frame.size.width, self.view.frame.size.height - yPosition)
        self.pdfListView.arrayPDF = self.arrayPDFList
//        pdfListView.backgroundColor = UIColor.redColor()
        self.pdfListView.setupViewsForList()
        self.pdfListView.delegate = self
        self.view.addSubview(self.pdfListView)
        
        
        self.arrayBanner.removeAllObjects()
        self.arrayBanner.addObject("article_doc_image")
        self.arrayBanner.addObject("article_doc_image")
        self.arrayBanner.addObject("article_doc_image")
        
        self.pageControl.numberOfPages = self.arrayBanner.count
        self.pageControl.currentPage = 0
        
        
        for (index, content) in enumerate(self.arrayBanner) {
            
            let x = Int(self.view.frame.size.width) * index
            let img = UIImageView(frame: CGRectMake(CGFloat(x) , 0, self.view.frame.size.width, self.scrollBanner.frame.size.height))
            img.image = UIImage (named: self.arrayBanner[index] as! NSString as String)
            self.scrollBanner.addSubview(img)
            
        }
        let scrollWidth = Int(self.view.frame.size.width) * self.arrayBanner.count
        self.scrollBanner.pagingEnabled = true
        self.scrollBanner.contentSize = CGSizeMake(CGFloat(scrollWidth), 0)
        self.scrollBanner.delegate = self
        self.pageControl.enabled = false
        self.view.bringSubviewToFront(self.pageControl)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Method
    func goToSearchPage() {
        
        self.performSegueWithIdentifier("toSearchView", sender: self)
        
    }
    
    // MARK: - Delegate
    
    func pdfListViewSelected(listView: PDFListView, selected: Int) {
        
        self.selectedIndex = selected
        self.performSegueWithIdentifier("toPDFView", sender: self)
        
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let scrollFrame = scrollView.contentOffset.x / scrollView.frame.size.width
        self.pageControl.currentPage = Int(scrollFrame)
        
    }
    
   

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toSearchView" {
            var controller = segue.destinationViewController as! SearchController
            controller.arrayPDFList = self.arrayPDFList
            
        }else if segue.identifier == "toPDFView" {
            println("Contents = \(self.arrayPDFList)")
            let pdfRepresentation: PDFModel = self.arrayPDFList.objectAtIndex(self.selectedIndex-1) as! PDFModel
            var controller = segue.destinationViewController as! PDFViewController
            controller.user = self.user
            controller.pdfRepresentation = pdfRepresentation
            
        }
        
    }
    


}
