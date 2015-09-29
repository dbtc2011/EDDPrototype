//
//  SearchController.swift
//  SURS
//
//  Created by IOSUSER006 on 10/16/14.
//  Copyright (c) 2014 Dev-Touch. All rights reserved.
//

import UIKit

class SearchController: UIViewController , UITextFieldDelegate{

    @IBOutlet var textSearch: UITextField!
    
    @IBOutlet var scrollPDFList: UIScrollView!
    
    var arrayPDFList: NSMutableArray = NSMutableArray()
    
    
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.hidesBackButton = true
        
        var xPosiotion = 20 as CGFloat
        
        for var count = 0; count < self.arrayPDFList.count; ++count {
            
            var button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
            button.frame = CGRectMake(xPosiotion, 10, 130, 180)
            button.setBackgroundImage(UIImage(named: "homepage_nocover"), forState: UIControlState.Normal)
            self.scrollPDFList.addSubview(button)
            
            xPosiotion = xPosiotion + 5 + 130
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var contentSizeScroll = ((self.arrayPDFList.count * 130)+(self.arrayPDFList.count * 5)) as Int
        
        contentSizeScroll = contentSizeScroll + 40
        
        self.scrollPDFList.contentSize = CGSizeMake(CGFloat(contentSizeScroll), 0)
        
        self.view.backgroundColor = UIColor.grayColor()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearButtonClicked(sender: UIButton) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Delegate
    // Mark: TextField
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }

}
