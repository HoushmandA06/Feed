//
//  AppDelegate.swift
//  Feed
//
//  Created by Ali Houshmand on 7/23/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
        
        var window: UIWindow?
        
        func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
            
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            
            var rootVC = RootViewController()
            
            var navVC = UINavigationController(rootViewController: rootVC)
            
            self.window!.rootViewController = navVC
            
            // nil is no longer an object
            // ? makes something a bool value... is object true or false
            // Override point for customization after application launch.
            
            self.window!.backgroundColor = UIColor.whiteColor()
            self.window!.makeKeyAndVisible()
            return true
            
        }
}




