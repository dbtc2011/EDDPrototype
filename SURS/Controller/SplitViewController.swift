//
//  SplitViewController.swift
//  SURS
//
//  Created by IOSUSER006 on 10/13/14.
//  Copyright (c) 2014 Dev-Touch. All rights reserved.
//

import UIKit

class SplitViewController: UIViewController {

    

    @IBOutlet var viewMenuSelection: UIView!
    @IBOutlet var buttonLibrary: UIButton!
    @IBOutlet var buttonMyAccount: UIButton!
    @IBOutlet var buttonSetting: UIButton!
    @IBOutlet var buttonLogout: UIButton!
    
    var arrayPDF: NSMutableArray = NSMutableArray()
    
    var user: UserInfo?
    
    
    var sursNavi:SURSNavigationController = SURSNavigationController()
    var arrayController: NSArray = NSArray (objects: "toHomePage", "toAccountPage", "toSettingsPage")
    

    
   
    
//    var arrayController = ["toHomePage", "toAccountPage", "toSettingsPage"] as NSArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.buttonLibrary.backgroundColor = UIColor(red: 26/255, green: 44/255, blue: 68/255, alpha: 1)
        
        sursNavi = self.navigationController as! SURSNavigationController
        
        let storyBoard = storyBoardToUse()
        
        var controller = storyBoard.instantiateViewControllerWithIdentifier(arrayController[0] as! String) as! SURSNavigationController
        controller.arrayPDF = self.arrayPDF
        controller.user = self.user
        self.addChildViewController(controller)
        self.view.addSubview(controller.view)
        
        controller .willMoveToParentViewController(self)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Functions
    
    @IBAction func libraryButtonClicked(sender: UIButton) {
        
        println("Library Button Clicked")
//        presentController(0)
        let oldController = self.childViewControllers.last as! UIViewController
        oldController .willMoveToParentViewController(nil)
        oldController.view .removeFromSuperview()
        oldController .removeFromParentViewController()
        
        
        let storyBoard = storyBoardToUse()
        let controller = storyBoard.instantiateViewControllerWithIdentifier(self.arrayController[0] as! NSString as String) as! SURSNavigationController
        controller.arrayPDF = self.arrayPDF
        controller.user = self.user
        self.addChildViewController(controller)
        self.view .addSubview(controller.view)
        
        controller .willMoveToParentViewController(self)
        
        setSelectedAllButtons(false)
        self.buttonLibrary.selected = true
        self.buttonLibrary.backgroundColor = UIColor(red: 26/255, green: 44/255, blue: 68/255, alpha: 1)
    }
    
    @IBAction func myAccountButtonClicked(sender: UIButton) {
        
        println("My Account Button Clicked")
        presentController(1)
        
        setSelectedAllButtons(false)
        self.buttonMyAccount.selected = true
        self.buttonMyAccount.backgroundColor = UIColor(red: 26/255, green: 44/255, blue: 68/255, alpha: 1)
    }
    
    @IBAction func buttonSettingClicked(sender: UIButton) {
        
        println("Settings Button Clicked")
        presentController(2)
        
        setSelectedAllButtons(false)
        self.buttonSetting.selected = true
        self.buttonSetting.backgroundColor = UIColor(red: 26/255, green: 44/255, blue: 68/255, alpha: 1)
        
    }
    
    @IBAction func buttonLogoutClicked(sender: UIButton) {
        
        println("Logout Button Clicked")
        
        setSelectedAllButtons(false)
        self.buttonLogout.selected = true
        self.buttonLogout.backgroundColor = UIColor(red: 26/255, green: 44/255, blue: 68/255, alpha: 1)
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
        
        
    }
    
    func presentController(index: Int) {
        
        
        let oldController = self.childViewControllers.last as! UIViewController
        oldController .willMoveToParentViewController(nil)
        oldController.view .removeFromSuperview()
        oldController .removeFromParentViewController()
        
        
        let storyBoard = storyBoardToUse()
        let controller = storyBoard.instantiateViewControllerWithIdentifier(arrayController[index] as! NSString as String) as! SURSNavigationController
        controller.user = self.user
        self.addChildViewController(controller)
        self.view .addSubview(controller.view)
        
        controller .willMoveToParentViewController(self)
    }
    
    
    func setSelectedAllButtons(value: Bool) {
        
        self.buttonLibrary.selected = value
        self.buttonMyAccount.selected = value
        self.buttonSetting.selected = value
        self.buttonLogout.selected = value
        
        self.buttonLibrary.backgroundColor = UIColor.clearColor()
        self.buttonMyAccount.backgroundColor = UIColor.clearColor()
        self.buttonSetting.backgroundColor = UIColor.clearColor()
        self.buttonLogout.backgroundColor = UIColor.clearColor()
        
        
    }
    
    func storyBoardToUse() -> UIStoryboard {
        
        var storyBoard = UIStoryboard(name: "Main(4)", bundle: nil)

        let size:CGFloat = UIScreen.mainScreen().bounds.size.height
        
        if size == 480
        {   // iPhone 3GS, 4, and 4S and iPod Touch 3rd and 4th generation: 3.5 inch screen (diagonally measured)
            // Instantiate a new storyboard object using the storyboard file named Storyboard_iPhone35
            storyBoard = UIStoryboard(name: "Main(3.5)", bundle: nil)
        }else if size == 667 {
            storyBoard = UIStoryboard(name: "Main(4.7)", bundle: nil)
        }
        
        
        return storyBoard
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
