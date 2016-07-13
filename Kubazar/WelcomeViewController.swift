//
//  WelcomeViewController.swift
//  Kubazar
//
//  Created by Alyson Vivattanapa on 7/13/16.
//  Copyright © 2016 Jimsalabim. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var kubazarLogoImageView: UIImageView!

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
      var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.alpha = 0
        signupButton.alpha = 0
        
        usernameTextField.alpha = 0
        passwordTextField.alpha = 0
        
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
        usernameTextField.alpha = 1
        passwordTextField.alpha = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
       
    }


    @IBAction func signupButtonPressed(sender: AnyObject) {
        let signupVC = SignupViewController()
        presentViewController(signupVC, animated: true, completion: nil)
    }
    
}
