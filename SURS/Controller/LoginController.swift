//
//  LoginController.swift
//  SURS
//
//  Created by IOSUSER006 on 10/10/14.
//  Copyright (c) 2014 Dev-Touch. All rights reserved.
//

import UIKit

class LoginController: UIViewController , UITextFieldDelegate{
    
    
    
    @IBOutlet var viewActivityIndicator: UIView!
    @IBOutlet var textFieldUsername: UITextField!
    @IBOutlet var textFieldPassword: UITextField!
    @IBOutlet var buttonLogin: UIButton!
    
    var arrayPDF:NSMutableArray = []
    var mutableData: NSMutableData?
//    var connect: DTConnect?
    var user: UserInfo?
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mutableData = nil
//        self.connect = nil
        self.user = UserInfo()
        self.user?.username = "markangeles"
        self.user?.address = "f.malanlo"
        self.user?.email = "mark13_06"
        self.user?.firstName = "Mark"
        self.user?.lastName = "Angeles"
        self.user?.fullName = self.user!.firstName + " " + self.user!.lastName
        self.user?.mobileNumber = "025555555"
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(true)
        self.arrayPDF.removeAllObjects()
        self.viewActivityIndicator.hidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        
//        self.performSegueWithIdentifier("toSplitView", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButtonClicked(sender: UIButton) {
        
        self.viewActivityIndicator.hidden = false
        
        
//        self.viewActivityIndicator.hidden = !self.viewActivityIndicator.hidden
        
        
        sampleWebservice()
        
    }
    
    // MARK: - Functions
    func hideActivityIndicator (){
    
        self.viewActivityIndicator.hidden = true
    }
    
    // MARK: - Delegate
    // MARK: TextField
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    /*
    // MARK: Connect
    func DTConnection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        
        
    }
    
    func DTConnection(connection: NSURLConnection!, didReceiveData data: NSData!, withFile file: String!) {

        self.mutableData?.appendData(data)
        
        
    }
    
    func DTConnectionDidFinishLoading(connection: NSURLConnection!) {
        
        let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(self.mutableData!, options: nil, error: nil)
        
        
        println("FUCK \(json)")
        
        if json!.isKindOfClass(NSDictionary) {
            let dictionary = json as NSDictionary
            let arrayData:NSArray = dictionary["articles"] as NSArray
            
            for (index, object) in enumerate(arrayData) {
                if object.isKindOfClass(NSDictionary) {
                    let dictionaryContent = object as NSDictionary
                    println("Contents \(object)")
                    
                    var pdfRepresentation = PDFModel()
                    pdfRepresentation.imgLink = dictionaryContent["thumbnail"] as NSString
                    
                    var pathUser = self.user?.pathForUser()
                    pathUser = pathUser!.stringByAppendingPathComponent("Thumbnails")
                    if NSFileManager.defaultManager().fileExistsAtPath(pathUser!) {
                        
                    }else {
                        NSFileManager.defaultManager().createDirectoryAtPath(pathUser!, withIntermediateDirectories: true, attributes: nil, error: nil)
                    }
                    pathUser = pathUser!.stringByAppendingPathComponent("\(index).png")
                    pdfRepresentation.imgPath = pathUser!
                    pdfRepresentation.pdfTitle = "\(index)"
                    pdfRepresentation.pdfPath = self.user!.pathForUser().stringByAppendingPathComponent("\(index)")
                    
                    if NSFileManager.defaultManager().fileExistsAtPath(pdfRepresentation.pdfPath) {
                        
                    }else {
                        NSFileManager.defaultManager().createDirectoryAtPath(pdfRepresentation.pdfPath, withIntermediateDirectories: true, attributes: nil, error: nil)
                    }
                    
                    
                    println("Path \(pdfRepresentation.pdfPath)")
                    self.arrayPDF.addObject(pdfRepresentation)
                    
                }
                
            }
            
            self.viewActivityIndicator.hidden = true
            self.performSegueWithIdentifier("toSplitView", sender: self)
            
        }
        
        
        let string = NSString(data: self.mutableData!, encoding: NSUTF8StringEncoding)
        
      
        
        
    }

    */
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        
//        var arrayPDFList: NSMutableArray = NSMutableArray()
//        
//        for var count = 1; count < 10; ++count {
//            let content: NSString = NSString(string: "PDF \(count)")
//            var pdfContents: PDFModel = PDFModel()
//            pdfContents.pdfTitle = content
//            arrayPDFList.addObject(pdfContents as PDFModel)
//            
//        }
        
       
        var controller: SplitViewController = segue.destinationViewController as! SplitViewController
        controller.arrayPDF = self.arrayPDF
        controller.user = self.user

 
        
    }
    
    
    
    
//    
//    func sampleWebservice() {
//        self.mutableData = nil
//        self.connect = nil
//        self.mutableData = NSMutableData()
//        self.connect = DTConnect()
//        self.connect?.name = "login"
//        self.connect?.delegate = self
//        self.connect?.postPageUsingDictionary(["username": "webservice",
//                                               "password": "webservice"], usingURLLink: "http://10.5.1.17/SURSv2/public/webservices/login")
//    
//        
//    }
    

}
