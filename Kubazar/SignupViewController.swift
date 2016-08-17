//
//  SignupViewController.swift
//  Kubazar
//
//  Created by Alyson Vivattanapa on 7/13/16.
//  Copyright © 2016 Jimsalabim. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var thirdView: UIView!
    
    @IBOutlet weak var signupEmailTextField: UITextField!
    
    @IBOutlet weak var signupUsernameTextField: UITextField!
    
    @IBOutlet weak var signupBirthdateDatePicker: UIDatePicker!
    
    @IBOutlet weak var signupPasswordTextField: UITextField!
    
    
    var timer = NSTimer()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        secondView.alpha = 0
        
        thirdView.alpha = 0
        
        signupEmailTextField.delegate = self
        
        signupUsernameTextField.delegate = self
        
        signupPasswordTextField.delegate = self
       
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func firstContinueButtonPressed(sender: AnyObject) {
        
        self.firstView.alpha = 0
        self.secondView.alpha = 1
     
    }
    
  
    @IBAction func secondContinueButtonPressed(sender: AnyObject) {
        
    createNewUser()
        
    }
    
    
    func createNewUser() {
        if let email = signupEmailTextField.text, password = signupPasswordTextField.text {
            FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user, error) in
                
                if error != nil {
                    self.presentViewController(Alerts.showErrorMessage((error?.localizedDescription)!), animated: true, completion: nil)
                    self.firstView.alpha = 1
                    self.secondView.alpha = 0
                    self.thirdView.alpha = 0
               
                } else {
                    
                    self.secondView.alpha = 0
                    self.thirdView.alpha = 1
                   
                    if let currentUser = user?.uid {
                    self.createNewUserProfile(currentUser)
                        
                        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(SignupViewController.changeRootViewToTabBarController), userInfo: nil, repeats: false)

                }
                }
            })
            
        }
    }
    
    func changeRootViewToTabBarController() {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    appDelegate.window?.rootViewController = appDelegate.tabBarController
    appDelegate.tabBarController?.selectedIndex = 0
    
    }
   
    func createNewUserProfile(uid: String) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let birthdate = dateFormatter.stringFromDate(signupBirthdateDatePicker.date)
        
        let signupUsername = signupUsernameTextField.text
        
        ClientService.profileRef.child("\(uid)/username").setValue(signupUsername)
        ClientService.profileRef.child("\(uid)/birthdate").setValue(birthdate)
        
    }
    

    


}
