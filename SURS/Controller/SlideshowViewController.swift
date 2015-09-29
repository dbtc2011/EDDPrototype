//
//  SlideshowViewController.swift
//  SURS
//
//  Created by IOSUSER006 on 11/3/14.
//  Copyright (c) 2014 Dev-Touch. All rights reserved.
//

import UIKit

class SlideshowViewController: UIViewController , UIScrollViewDelegate{
    
    var arrayImages:NSMutableArray?
    
    @IBOutlet weak var scrollImages: UIScrollView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPage: UILabel!
    
    var stringLabel: NSString?
    var user: UserInfo?
    var pdfRepresentation: PDFModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelTitle.text = self.stringLabel! as String
        self.labelPage.text = "Page 1 of \(self.arrayImages!.count)"
       


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        println("Objects = \(self.arrayImages)")
        for (index, object) in enumerate(self.arrayImages!) {
            if object.isKindOfClass(NSDictionary) {
                let dictionary = object as! NSMutableDictionary
                
                dispatch_async(dispatch_get_main_queue(), {
                    let imagePath:NSString = self.pdfRepresentation!.pdfPath.stringByAppendingPathComponent(dictionary["src"] as! NSString as String)
                    println("Images \(imagePath)")
                    var xPosition = Int(self.scrollImages.frame.size.width) * index
                    let imageView = UIImageView(frame: CGRectMake(CGFloat(xPosition), 0, self.scrollImages.frame.size.width, self.scrollImages.frame.size.height))
                    imageView.image = UIImage(contentsOfFile: imagePath as String)
                    imageView.contentMode = UIViewContentMode.ScaleAspectFit
                    self.scrollImages.addSubview(imageView)
                })
                
                
            }
        }
        
        var totalWidth = Int(self.scrollImages.frame.size.width) * self.arrayImages!.count
        self.scrollImages.contentSize = CGSizeMake(CGFloat(totalWidth), 0)
        self.scrollImages.delegate = self
        self.scrollImages.pagingEnabled = true
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Delegate
    // MARK: ScrollView
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let divider =  (scrollView.contentOffset.x / scrollView.frame.size.width) + 1

        println("divider \(divider)")
        
        self.labelPage.text = "Page \(Int(divider)) of \(self.arrayImages!.count)"
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
