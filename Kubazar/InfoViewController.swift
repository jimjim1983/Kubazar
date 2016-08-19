//
//  InfoViewController.swift
//  Kubazar
//
//  Created by Alyson Vivattanapa on 7/13/16.
//  Copyright © 2016 Jimsalabim. All rights reserved.
//

import UIKit
import Firebase

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signOutButtonPressed(sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        print("sign out button pressed")
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let welcomeVC = WelcomeViewController()
        appDelegate.window?.rootViewController = welcomeVC
        
    }
  

}
