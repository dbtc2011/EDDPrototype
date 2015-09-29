//
//  AudioViewController.swift
//  SURS
//
//  Created by IOSUSER006 on 11/3/14.
//  Copyright (c) 2014 Dev-Touch. All rights reserved.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController {

    @IBOutlet weak var buttonPlay: UIButton!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    var stringTitle: NSString?
    var stringLink: NSString?
    var audioPlayer: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.labelTitle.text = self.stringTitle! as String
        println("audio file \(self.stringLink!)")
        
        
        let avItem = AVPlayerItem(URL: NSURL(string: self.stringLink! as String))
        
        self.audioPlayer = AVPlayer(playerItem: avItem)
        self.audioPlayer?.addObserver(self, forKeyPath: "rate", options: nil, context: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.audioPlayer?.removeObserver(self, forKeyPath: "rate")
        self.audioPlayer = nil
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.audioPlayer?.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonClicked(sender: UIButton) {
        println("PLAY!!")
      
        self.audioPlayer?.seekToTime(CMTimeMake(39, 1))
    }

    
    // MARK: - Observer
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        
        if self.audioPlayer?.rate == 0 {
            println("nag Zero")
        }
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
