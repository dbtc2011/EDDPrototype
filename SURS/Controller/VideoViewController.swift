//
//  VideoViewController.swift
//  SURS
//
//  Created by IOSUSER006 on 11/3/14.
//  Copyright (c) 2014 Dev-Touch. All rights reserved.
//

import UIKit
import MediaPlayer

class VideoViewController: UIViewController {

    
    @IBOutlet var viewActivityIndicator: UIView!
    var mediaPlayer = MPMoviePlayerController()
    
    @IBOutlet weak var labelTitle: UILabel!
    var videoLink: NSString?
    var stringTitle: NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "moviePlayerChanged", name: MPMoviePlayerLoadStateDidChangeNotification, object: nil)
        
        self.labelTitle.text = self.stringTitle! as String
        
        let url = NSURL(string: self.videoLink! as String)
        
        self.mediaPlayer.contentURL = url
        self.mediaPlayer.view.frame = CGRectMake((320/2)-(300/2), (568/2)-(200/2), 300, 200)
        self.mediaPlayer.shouldAutoplay = false
        self.mediaPlayer.setFullscreen(false, animated: true)
        self.mediaPlayer.movieSourceType = MPMovieSourceType.File
        self.mediaPlayer.prepareToPlay()
        
        self.view.addSubview(self.mediaPlayer.view)
        
        self.view.bringSubviewToFront(self.viewActivityIndicator)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(true)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if !self.mediaPlayer.fullscreen {
            self.mediaPlayer.stop()
        }
        
        
    }
    
    func moviePlayerChanged () {
        
        println("PUMASOK SA CHANGED")
        self.viewActivityIndicator.hidden = true

        
        
        
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
