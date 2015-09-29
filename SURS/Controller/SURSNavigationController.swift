//
//  SURSNavigationController.swift
//  SURS
//
//  Created by IOSUSER006 on 10/13/14.
//  Copyright (c) 2014 Dev-Touch. All rights reserved.
//

/*
 Button Tag                               Function
    1                                     Menu Clicked
    2                                     Search Button Clicked
    3                                     Article Button Clicked


*/
import UIKit

class SURSNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    var buttonMenu: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
    var buttonSearch: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
    var buttonArticle: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
    
    
    var arrayPDF: NSMutableArray = NSMutableArray()
    var user: UserInfo?
    
    var isPressMenu: Bool = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var imgLogo: UIImageView = UIImageView(frame: CGRectMake((self.navigationBar.frame.size.width/2)-(130/2), 0, 130, self.navigationBar.frame.size.height))
        imgLogo.backgroundColor = UIColor .redColor()
        self.navigationBar.addSubview(imgLogo)
        
        self.buttonMenu.tag = 1
        self.buttonMenu.setImage(UIImage(named: "headericon_menu"), forState: UIControlState.Normal)
        self.buttonMenu.addTarget(self, action: "menuButtonClicked:", forControlEvents:.TouchUpInside)
        
        self.buttonMenu.frame = CGRectMake(10, 5, 30, 30)
        
        self.navigationBar.addSubview(self.buttonMenu)
        
        
        self.buttonSearch.backgroundColor = UIColor.clearColor()
        self.buttonSearch.addTarget(self, action: "searchPDFButtonClicked:", forControlEvents:.TouchUpInside)
        self.buttonSearch.frame = CGRectMake(250, 5, 30, 30)
        
        self.navigationBar.addSubview(self.buttonSearch)
        
        self.buttonArticle.frame = CGRectMake(self.navigationBar.frame.size.width - 35, 5, 30, 30)
        self.buttonArticle.addTarget(self, action: "articleButtonClicked:", forControlEvents:.TouchUpInside)
        self.buttonArticle.backgroundColor = UIColor.clearColor()
        self.navigationBar.addSubview(self.buttonArticle)

        self.delegate = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    // MARK: - Functions
    
    func menuButtonClicked(sender: UIButton) {
        
        animateMenuSelection()
        
    }
    
    func searchPDFButtonClicked(sender: UIButton) {
        if sender.tag == 5 {
            let controller = self.viewControllers.last as ArticleController
            controller.searchArticle()
            
        }
    }
    
    func articleButtonClicked(sender: UIButton) {
        
        println("last button clicked")
        
        if sender.tag == 3 {
            let controller = self.viewControllers.last as ArticleController
            controller.animateArticle()
        }else if sender.tag == 2 {
            let controller = self.viewControllers[0] as HomeController
            controller.goToSearchPage()
        }else if sender.tag == 4 {
            self.popViewControllerAnimated(true)
        }
    }
    
    func animateMenuSelection(){
        
        UIView.animateWithDuration(0.2, animations: {
            
            
            var frame:CGRect = self.view.frame
            
            frame.origin.x = self.isPressMenu ? self.dynamicWidth() : 0;
            self.view.frame = frame;
            println("Start Animation")
            }, completion: {
                (value: Bool) in
                self.isPressMenu = !self.isPressMenu
                println("DONE!!!")
        })
        
    }
    
    func dynamicWidth() -> CGFloat {
        // iPhone 4
        var returnValue:CGFloat = 250 as CGFloat
        
        if UIScreen.mainScreen().bounds.height == 667 {
            returnValue = 300
        }
            
        else if UIScreen.mainScreen().bounds.height == 736 {
            returnValue = 350
        }
        
        return returnValue
    }
    
    

    // MARK: - Delegate
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        
        self.buttonArticle.tag = 0
        self.buttonSearch.tag = 0
        self.buttonArticle.hidden = false
        self.buttonSearch.hidden = false
        self.buttonArticle.backgroundColor = UIColor.clearColor()
        self.navigationBarHidden = false
        self.buttonMenu.hidden = false
        if viewController.isKindOfClass(LoginController){
           
            self.navigationBarHidden = true
    
        }
        
        if viewController.isKindOfClass(SplitViewController){

            self.navigationBarHidden = true
            
        }
        
        if viewController.isKindOfClass(HomeController) {
            self.buttonArticle.tag = 2
            self.buttonArticle.setImage(UIImage(named: "headericon_ssearch"), forState: UIControlState.Normal)
            
            self.buttonSearch.hidden = true
            
            
        }
        
        if viewController.isKindOfClass(ArticleController) {
            self.buttonArticle.tag = 3
            self.buttonArticle.setImage(UIImage(named: "headericon_slide"), forState: UIControlState.Normal)
            
            self.buttonSearch.tag = 5
            self.buttonSearch.setImage(UIImage(named: "headericon_ssearch"), forState: UIControlState.Normal)

        }
        
        if viewController.isKindOfClass(AccountController) ||  viewController.isKindOfClass(PDFViewController){
            
            
            self.buttonArticle.hidden = true
            self.buttonSearch.hidden = true
        }
        
        if viewController.isKindOfClass(SearchController) {
            
            self.buttonArticle.setImage(nil, forState: UIControlState.Normal)
            self.buttonArticle.backgroundColor = UIColor.redColor()
            self.buttonArticle.tag = 4
            self.buttonSearch.hidden = true
        }
        
        if viewController.isKindOfClass(VideoViewController) || viewController.isKindOfClass(ImageViewController) || viewController.isKindOfClass(SlideshowViewController){
            
            
            self.buttonArticle.hidden = true
            self.buttonSearch.hidden = true
            self.buttonMenu.hidden = true
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
