//
//  AppDelegate.swift
//  SURS
//
//  Created by IOSUSER006 on 10/10/14.
//  Copyright (c) 2014 Dev-Touch. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
//        CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
        
        let size:CGFloat = UIScreen.mainScreen().bounds.size.height
        var initialViewController:UIViewController!
        
        if (size == 480)
        {   // iPhone 3GS, 4, and 4S and iPod Touch 3rd and 4th generation: 3.5 inch screen (diagonally measured)
            println("iPhone 4")
            // Instantiate a new storyboard object using the storyboard file named Storyboard_iPhone35
            let storyBoard = UIStoryboard(name: "Main(3.5)", bundle: nil)

            
            // Instantiate the initial view controller object from the storyboard
            initialViewController = storyBoard.instantiateInitialViewController() as UIViewController
        }
        
        if size == 568
        {
            // iPhone 5 and iPod Touch 5th generation: 4 inch screen (diagonally measured)
        
            // Instantiate a new storyboard object using the storyboard file named Storyboard_iPhone4
            let storyBoard = UIStoryboard(name: "Main(4)", bundle: nil)
            println("iPhone5")
            
            // Instantiate the initial view controller object from the storyboard
            initialViewController = storyBoard.instantiateInitialViewController() as UIViewController
        }else if size == 667 {
            // iPhone 6
            
            // Instantiate a new storyboard object using the storyboard file named Storyboard_iPhone4
            let storyBoard = UIStoryboard(name: "Main(4.7)", bundle: nil)
            println("iPhone5")
            
            // Instantiate the initial view controller object from the storyboard
            initialViewController = storyBoard.instantiateInitialViewController() as UIViewController
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

