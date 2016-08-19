//
//  WelcomeViewController.swift
//  Kubazar
//
//  Created by Alyson Vivattanapa on 7/13/16.
//  Copyright © 2016 Jimsalabim. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var kubazarLogoImageView: UIImageView!

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
      var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        
        passwordTextField.delegate = self

        loginButton.alpha = 0
        signupButton.alpha = 0
        
        emailTextField.alpha = 0
        passwordTextField.alpha = 0
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(WelcomeViewController.changeWelcomeLabel), userInfo: nil, repeats: false)
       
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WelcomeViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WelcomeViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    func keyboardWillHide(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        self.view.frame.origin.y += keyboardSize.height
    }
    

    func keyboardWillShow(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        let offset: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size
        
        if keyboardSize.height == offset.height {
            if self.view.frame.origin.y == 0 {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.view.frame.origin.y -= keyboardSize.height
                })
            }
        } else {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.view.frame.origin.y += keyboardSize.height - offset.height
            })
        }
//        print(self.view.frame.origin.y)
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
        emailTextField.alpha = 1
        passwordTextField.alpha = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        
        if let email = emailTextField.text, password = passwordTextField.text {
        
        FIRAuth.auth()?.signInWithEmail(email, password: password) { (user, error) in
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = appDelegate.tabBarController
            appDelegate.tabBarController?.selectedIndex = 0
           
        }
        }
    }


    @IBAction func signupButtonPressed(sender: AnyObject) {
        let signupVC = SignupViewController()
        presentViewController(signupVC, animated: true, completion: nil)
    }
    
}
