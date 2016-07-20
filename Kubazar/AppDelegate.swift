//
//  AppDelegate.swift
//  Kubazar
//
//  Created by Jim Petri on 08/06/16.
//  Copyright © 2016 Jimsalabim. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabBarController: UITabBarController?

//    let ref = Firebase(url: "https://kubazar-68697.firebaseio.com/")
//    deprecated b/c old firebase

//    var rootRef = FIRDatabase.database().reference()
// Database URL is automatically determined from GoogleService-Info.plist
// can't put this code here because Firebase needs to be configured first

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        FIRApp.configure()
        
        FIRDatabase.database().persistenceEnabled = true
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        
        tabBarController = UITabBarController()
        let firstTab = BazarViewController(nibName: "BazarViewController", bundle: nil)
        let secondTab = StartViewController(nibName: "StartViewController", bundle: nil)
        let thirdTab = FriendsViewController(nibName: "FriendsViewController", bundle: nil)
        let fourthTab = InfoViewController(nibName: "InfoViewController", bundle: nil)
        let controllers = [firstTab, secondTab, thirdTab, fourthTab]
        tabBarController?.viewControllers = controllers
        
        //firstTab.tabBarItem =
    
        
        FIRAuth.auth()!.addAuthStateDidChangeListener() { (auth, user) in
            if let user = user {
                print("User is signed in with uid:", user.uid)
                self.window?.rootViewController = self.tabBarController
            } else {
                print("No user is signed in.")
                let welcomeVC = WelcomeViewController()
                self.window?.rootViewController = welcomeVC
            }
        }
        

        
        self.window?.rootViewController = self.tabBarController
        
        
//     //    the following code doesn't work :(
//        if FBSDKAccessToken.currentAccessToken() != nil {
//            let startGameVC = StartGameViewController()
//            self.window?.rootViewController = startGameVC
//        } else {
//            let loginVC = LoginViewController()
//            self.window?.rootViewController = loginVC
//        }
//        

        
        
//        
//        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
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
        
        FBSDKAppEvents.activateApp()
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
       return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
//        return true
    }
    

}

