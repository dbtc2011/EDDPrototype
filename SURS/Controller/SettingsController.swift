//
//  SettingsController.swift
//  SURS
//
//  Created by IOSUSER006 on 10/14/14.
//  Copyright (c) 2014 Dev-Touch. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

    @IBOutlet var buttonDate: UIButton!
    @IBOutlet var buttonName: UIButton!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nameClicked(sender: UIButton) {
        self.buttonName.setImage(UIImage (named: "viewby_name"), forState: UIControlState.Normal)
        self.buttonDate.setImage(UIImage (named: "viewby_date_inactive"), forState: UIControlState.Normal)
        
    }

    @IBAction func dateClicked(sender: UIButton) {
        self.buttonName.setImage(UIImage (named: "viewby_name_inactive"), forState: UIControlState.Normal)
        self.buttonDate.setImage(UIImage (named: "viewby_date_active"), forState: UIControlState.Normal)
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
