//
//  WelcomeViewController.swift
//  Kubazar
//
//  Created by Alyson Vivattanapa on 7/12/16.
//  Copyright © 2016 Jimsalabim. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var kubazarLogoImageView: UIImageView!
   
    var timer = NSTimer()
  
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.alpha = 0
        signupButton.alpha = 0
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(WelcomeViewController.changeWelcomeLabel), userInfo: nil, repeats: false)

        // Do any additional setup after loading the view.
    }
    
    func changeWelcomeLabel() {
        welcomeLabel.text = "Let's create Haikus together"
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(WelcomeViewController.showLoginOrSignup), userInfo: nil, repeats: false)
    }
    
    func showLoginOrSignup() {
        welcomeLabel.alpha = 0
        kubazarLogoImageView.alpha = 0
        loginButton.alpha = 1
        signupButton.alpha = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
