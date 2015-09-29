//
//  AccountController.swift
//  SURS
//
//  Created by IOSUSER006 on 10/14/14.
//  Copyright (c) 2014 Dev-Touch. All rights reserved.
//

import UIKit

class AccountController: UIViewController , UITextFieldDelegate{
    @IBOutlet var textName: UITextField!

    @IBOutlet var textEmail: UITextField!
    
    @IBOutlet var textAddress: UITextField!
    
    @IBOutlet var textContact: UITextField!
    
    
    
    var user: UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.clearColor()
        let navi: SURSNavigationController = self.navigationController as! SURSNavigationController
        self.user = navi.user
        
        self.textName.text = self.user?.fullName
        self.textEmail.text = self.user?.email
        self.textAddress.text = self.user?.address
        self.textContact.text = self.user?.mobileNumber
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        return false
        
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
