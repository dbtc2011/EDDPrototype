//
//  ImageViewController.swift
//  SURS
//
//  Created by Mark Joel Roldan on 11/5/14.
//  Copyright (c) 2014 Dev-Touch. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    
    var stringTitle: NSString?
    var stringImagePath: NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.labelTitle.text = self.stringTitle! as String
        self.imageDisplay.image = UIImage(contentsOfFile: self.stringImagePath! as String)
        self.imageDisplay.contentMode = UIViewContentMode.ScaleAspectFit
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
