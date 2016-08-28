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
    
    @IBOutlet weak var welcomeToKubazarLabel: UILabel!
    
    @IBOutlet weak var letsWriteHaikusTogetherLabel: UILabel!
    
    @IBOutlet weak var kubazarImage: UIImageView!
    
    
    @IBOutlet weak var secondKubazarImage: UIImageView!
    
    @IBOutlet weak var createAccount: UILabel!
    
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var thirdView: UIView!
    
    @IBOutlet weak var signupEmailTextField: UITextField!
    
    @IBOutlet weak var signupUsernameTextField: UITextField!
    
    @IBOutlet weak var signupBirthdateDatePicker: UIDatePicker!
    
    @IBOutlet weak var signupPasswordTextField: UITextField!
    
    
    @IBOutlet weak var firstContinueButton: UIButton!
    
    var timer: NSTimer!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        secondView.alpha = 0
        
        thirdView.alpha = 0
        
        firstView.alpha = 1
        
        signupEmailTextField.delegate = self
        
        signupUsernameTextField.delegate = self
        
        signupPasswordTextField.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WelcomeViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WelcomeViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
       
        
    }
    

    
    override func viewWillAppear(animated: Bool) {
        
        firstViewAnimation()
        
    }
    
    func firstViewAnimation() {
        
    let viewBoundsHeight = view.bounds.height
        
//    let originWelcomeY = welcomeToKubazarLabel.center.y
//    welcomeToKubazarLabel.center.y -= view.bounds.height
//        
//   
        
//    let originLetsWriteY = letsWriteHaikusTogetherLabel.center.y
//    letsWriteHaikusTogetherLabel.center.y -= viewBoundsHeight
        
    let kubazarX = kubazarImage.center.x
    kubazarImage.center.x -= viewBoundsHeight
//        
//    let createAccountY = createAccount.center.y
//    createAccount.center.y -= viewBoundsHeight
//
//    let emailY = signupEmailTextField.center.y
//    signupEmailTextField.center.y -= viewBoundsHeight
//        
//    let passwordY = signupPasswordTextField.center.y
//    signupPasswordTextField.center.y -= viewBoundsHeight
//        
//    let continueY = firstContinueButton.center.y
//    firstContinueButton.center.y -= viewBoundsHeight
    
    UIView.animateWithDuration(1.6, delay: 0, usingSpringWithDamping: 0.37, initialSpringVelocity: 6.7, options: .CurveEaseIn, animations: {
//    self.welcomeToKubazarLabel.center.y = originWelcomeY
//    self.letsWriteHaikusTogetherLabel.center.y = originLetsWriteY
    self.kubazarImage.center.x = kubazarX
//    self.createAccount.center.y = createAccountY
//    self.signupEmailTextField.center.y = emailY
//    self.signupPasswordTextField.center.y = passwordY
//    self.firstContinueButton.center.y = continueY
    
    }, completion: nil)
    
    
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func isValidEmail(emailStr: String) -> Bool {
        if emailStr.containsString("@") {
            return true
        } else {
            return false
        }
    }
    

    @IBAction func firstContinueButtonPressed(sender: AnyObject) {
        
        firstView.endEditing(true)
        
        if let text = signupEmailTextField.text where !text.isEmpty && isValidEmail(text) == true
        {
            let viewBoundsHeight = view.bounds.height
            let secondKubazarX = secondKubazarImage.center.x
            secondKubazarImage.center.x -= viewBoundsHeight
            
            self.firstView.alpha = 0
            self.secondView.alpha = 1
            
            UIView.animateWithDuration(1.6, delay: 0, usingSpringWithDamping: 0.37, initialSpringVelocity: 6.7, options: .CurveEaseIn, animations: {
               
                self.secondKubazarImage.center.x = secondKubazarX
                
                }, completion: nil)
            
        } else {
                
                
            self.presentViewController(Alerts.showErrorMessage("Please enter a valid email address."), animated: true, completion: nil)
        }
        
     
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
        
        let email = signupEmailTextField.text
        
        let signupUsername = signupUsernameTextField.text
        
        ClientService.profileRef.child("\(uid)/username").setValue(signupUsername)
        ClientService.profileRef.child("\(uid)/birthdate").setValue(birthdate)
        ClientService.profileRef.child("\(uid)/email").setValue(email)
        
    }
    

    
    @IBAction func firstViewBackButtonPressed(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion:  nil)
    }
    
    
    @IBAction func secondViewBackButtonPressed(sender: AnyObject) {
        
        secondView.alpha = 0
        thirdView.alpha = 0
        firstView.alpha = 1
    }
    
   
    
    
//    func isValidEmail(testStr:String) -> Bool {
//        print("validate emilId: \(testStr)")
//        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        let result = emailTest.evaluateWithObject(testStr)
//        return result
//    }
    


}
