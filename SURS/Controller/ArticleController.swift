//
//  ArticleController.swift
//  SURS
//
//  Created by IOSUSER006 on 10/16/14.
//  Copyright (c) 2014 Dev-Touch. All rights reserved.
//

import UIKit
import MediaPlayer

protocol ArticleControllerDelegate {
    
    func articleControllerSelected (artcile: ArticleController, selected: Int)
}



class ArticleController: UIViewController, UITextFieldDelegate ,UITableViewDelegate, UITableViewDataSource , PDFSplitListViewDelegate{
    
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var textSearch: UITextField!
    @IBOutlet var buttonSlider: UIButton!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var textArticle: UITextView!
    @IBOutlet var tableMain: UITableView!
    
    
    var slider = PDFPSplitListView(frame: CGRectMake(0, 568, 320, 120))
    var filePathPDF:NSString?
    var totalPageNumber:Int?
    
    var indexSelected:NSIndexPath!
    
    
    var arrayEnhancement: NSMutableArray?
    
    var isAnimating = false
    
    var delegate:ArticleControllerDelegate?
    
    var user: UserInfo?
    var pdfRepresentation: PDFModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.buttonSlider.addTarget(self, action: "aniateSlider", forControlEvents: .TouchUpInside)
        self.navigationItem.hidesBackButton = true
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.tableMain.alpha = 0.95
        println("enhancement are \(self.arrayEnhancement)")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(true)
        
        self.slider.frame = CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 150)
        self.slider.delegate = self
        self.slider.setupPages(0, totalPage: self.totalPageNumber!, pdfPath: self.filePathPDF!)
        self.view.addSubview(self.slider)
        self.view.bringSubviewToFront(self.buttonSlider)
        
    }
    
    
    
    override func viewDidDisappear(animated: Bool) {
        
        super.viewDidDisappear(true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setup
    @IBAction func clearSearch(sender: UIButton) {
    }
    func setUpArticleList (selectedTitle: NSString, selectedIndex: Int) {
        
    }
    
    func searchArticle() {
        if !self.isAnimating{
            self.viewSearch.hidden = !self.viewSearch.hidden
            self.isAnimating = !self.isAnimating
            var yPosition = 64 as CGFloat
            
            if yPosition == self.viewSearch.frame.origin.y {
                yPosition = self.viewSearch.frame.origin.y - self.viewSearch.frame.size.height
            }
            
            UIView.animateKeyframesWithDuration(0.3, delay: 0, options: nil, animations: {
                self.viewSearch.frame = CGRectMake(self.viewSearch.frame.origin.x, yPosition, self.viewSearch.frame.size.width, self.viewSearch.frame.size.height)
                
                
                }, completion: { finished in
                    self.isAnimating = !self.isAnimating
            })
        }
    }
    
    
    // MARK: - Function
    func animateArticle() {
        if !self.isAnimating{
            self.tableMain.hidden = !self.tableMain.hidden
            self.isAnimating = !self.isAnimating
            var yPosition = 64 as CGFloat
            
            if yPosition == self.tableMain.frame.origin.y {
                yPosition = self.tableMain.frame.origin.y - self.tableMain.frame.size.height
            }
            
            UIView.animateKeyframesWithDuration(0.3, delay: 0, options: nil, animations: {
                self.tableMain.frame = CGRectMake(self.tableMain.frame.origin.x, yPosition, self.tableMain.frame.size.width, self.tableMain.frame.size.height)
                
                
                }, completion: { finished in
                    self.isAnimating = !self.isAnimating
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
//                    self.isSliderShown = !self.isSliderShown
                    
                    
            })
            
            
        }

    }
    
    // MARK: - Delegate 
    // MARK: - TableView
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let dictionaryContent = self.arrayEnhancement!.objectAtIndex(section) as! NSMutableDictionary
        
        var viewHeader = UIView(frame: CGRectMake(0, 0, self.tableMain.frame.size.width, 40))
        viewHeader.backgroundColor = UIColor.clearColor()
        
        
        let labelSection = UILabel(frame: CGRectMake(0, 0, self.tableMain.frame.size.width, 40))
        labelSection.backgroundColor = UIColor.darkGrayColor()
        labelSection.text = dictionaryContent["page"] as! NSString as String
        labelSection.adjustsFontSizeToFitWidth = true
        viewHeader.addSubview(labelSection)
        
        return viewHeader
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        
        return 40 as CGFloat
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let dictionaryContent = self.arrayEnhancement!.objectAtIndex(section) as! NSMutableDictionary
        let arrayContent = dictionaryContent["content"] as! NSMutableArray
        
        return arrayContent.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return self.arrayEnhancement!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableMain.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        var color = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1) as UIColor
        
        if (indexPath.row+1) % 2 == 0 {
            color = UIColor (red: 236/255, green: 236/255, blue: 236/255, alpha: 1)
        }
        let dictionaryContent = self.arrayEnhancement!.objectAtIndex(indexPath.section) as! NSMutableDictionary
        let arrayContent = dictionaryContent["content"] as! NSMutableArray
        let dictionaryEnhancement = arrayContent.objectAtIndex(indexPath.row) as! NSMutableDictionary
        cell.contentView.backgroundColor = color
        //243, 235
        
        cell.textLabel!.backgroundColor = UIColor.clearColor()
        cell.textLabel!.adjustsFontSizeToFitWidth = true
        cell.textLabel!.text = dictionaryEnhancement["title"] as! NSString as String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.indexSelected = indexPath
        
        let dictionaryContent = self.arrayEnhancement!.objectAtIndex(indexPath.section) as! NSMutableDictionary
        let arrayContent = dictionaryContent["content"] as! NSMutableArray
        let dictionaryEnhancement = arrayContent.objectAtIndex(indexPath.row) as! NSMutableDictionary
        
        self.textArticle.text = dictionaryEnhancement["title"] as! NSString as String
        
        if dictionaryEnhancement["type"] as! NSString == "video" {
            
            self.performSegueWithIdentifier("toVideoController", sender: self)
            
        }else if dictionaryEnhancement["type"] as! NSString == "audio" {
            self.performSegueWithIdentifier("toVideoController", sender: self)
//            self.performSegueWithIdentifier("toAudioController", sender: self)
            
        }else if dictionaryEnhancement["type"] as! NSString == "text" {
            
            self.textArticle.text = dictionaryEnhancement["value"] as! NSString as String
//            self.performSegueWithIdentifier("toVideoController", sender: self)
            
        }else if dictionaryEnhancement["type"] as! NSString == "href" {
            
//            self.performSegueWithIdentifier("toVideoController", sender: self)
            
        }else if dictionaryEnhancement["type"] as! NSString == "slideshow" {
            
            self.performSegueWithIdentifier("toSlideshowController", sender: self)
            
        }else if dictionaryEnhancement["type"] as! NSString == "image" {
            
            self.performSegueWithIdentifier("toImageController", sender: self)
            
        }
        
        
        
        
        
    }
    // MARK: - SplitListView
    
    func pdfSplitListView(splitView: PDFPSplitListView, selected: Int) {
        
        
        let navigatation = self.navigationController as! SURSNavigationController
        self.delegate?.articleControllerSelected(self, selected: selected)
        
        navigatation.popViewControllerAnimated(true)
        
        
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.isAnimating = true
        return true
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.isAnimating = false
        return true
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let dictionaryContent = self.arrayEnhancement!.objectAtIndex(self.indexSelected.section) as! NSMutableDictionary
        let arrayContent = dictionaryContent["content"] as! NSMutableArray
        let dictionaryEnhancement = arrayContent.objectAtIndex(self.indexSelected.row) as! NSMutableDictionary
        
        if segue.identifier == "toVideoController" {
            
            let controller = segue.destinationViewController as! VideoViewController
            controller.videoLink = dictionaryEnhancement["src"] as! NSString!
            controller.stringTitle = dictionaryEnhancement["title"] as! NSString!
            
            
        }else if segue.identifier == "toSlideshowController" {
            
            let controller = segue.destinationViewController as! SlideshowViewController
            controller.arrayImages = dictionaryEnhancement["images"] as! NSMutableArray!
            controller.user = self.user
            controller.pdfRepresentation = self.pdfRepresentation
            controller.stringLabel = dictionaryEnhancement["title"] as! NSString!
            
            
        }else if segue.identifier == "toAudioController" {
            
            
            let controller = segue.destinationViewController as! VideoViewController
            controller.videoLink = dictionaryEnhancement["src"] as! NSString!
            controller.stringTitle = dictionaryEnhancement["title"] as! NSString!
            
        }else if segue.identifier == "toImageController" {
            
            
            var imagePath = self.pdfRepresentation?.pdfPath.stringByAppendingPathComponent(dictionaryEnhancement["src"] as! NSString as String)
            let controller = segue.destinationViewController as! ImageViewController
            controller.stringImagePath = imagePath!
            controller.stringTitle = dictionaryEnhancement["title"] as! NSString!
            
        }else if segue.identifier == "" {
            
        }
        
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

