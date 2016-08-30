//
//  FriendsViewController.swift
//  Kubazar
//
//  Created by Alyson Vivattanapa on 7/13/16.
//  Copyright © 2016 Jimsalabim. All rights reserved.
//

import UIKit
import MessageUI

class FriendsViewController: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var xButton: UIButton!
    
    @IBOutlet weak var friendsTableView: UITableView!
    
    @IBOutlet weak var inviteNewFriendsView: UIView!
    
    @IBOutlet weak var friendsEmailTextField: UITextField!

    @IBOutlet weak var inviteNewFriendsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       friendsEmailTextField.autocapitalizationType = .None
        
       friendsEmailTextField.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FriendsViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FriendsViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)


        // Do any additional setup after loading the view.
    }
        
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
    }
    
    //table view for friends list
    
    //add new friend
    
    //duplicate data?
    
    // if you don't have any friends, tableView alpha is zero, and you display label that says: "You don't have any friends yet."

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
         inviteNewFriendsView.alpha = 0
    }
    
    func inviteNewFriendsViewSetup() {
        inviteNewFriendsView.layer.cornerRadius = 33
        inviteNewFriendsView.alpha = 1
        inviteNewFriendsButton.alpha = 0
    }
    
    
    
    @IBAction func xButtonPressed(sender: AnyObject) {
        inviteNewFriendsView.alpha = 0
        inviteNewFriendsButton.alpha = 1
        friendsEmailTextField.text? = ""
        
    }
    
    
    
    @IBAction func inviteNewFriendsButtonPressed(sender: AnyObject) {
        
        inviteNewFriendsViewSetup()
        
    }
    
    
    
    func isValidEmail(emailStr: String) -> Bool {
        if emailStr.containsString("@") {
            return true
        } else {
            return false
        }
    }
    
    
    @IBAction func addFriendButtonPressed(sender: AnyObject) {
        
        view.endEditing(true)
        
        if let friendsEmailText = friendsEmailTextField.text?.lowercaseString {
            if !friendsEmailText.isEmpty && isValidEmail(friendsEmailText) == true {
                print(friendsEmailText)
                
                ClientService.profileRef.queryOrderedByChild("email").queryEqualToValue(friendsEmailText).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                    
                    if snapshot.exists() {
                        
                       let friendUID = snapshot.key
                        
                        
                        
                       print(snapshot)
                        
                        print("user exists")
                    } else {
                        print("user does not exist")
                        self.sendInvitationEmail(friendsEmailText)
                    }
                    
                })
            }
        }
    }

    func sendInvitationEmail(email: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            mail.setSubject("Play Kubazar with me!")
            mail.setMessageBody("<p>Play Kubazar with me!</p>", isHTML: true)
            
           presentViewController(mail, animated: true, completion: nil)
        } else {
            presentViewController(Alerts.showErrorMessage("You aren't currently able to send an invitation email. Please try again later."), animated: true, completion: nil)
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true) { 
            self.inviteNewFriendsViewSetup()
        }
        
    }
    
    func addExistingUserAsFriend(emailAddress: String) {
        
        let currentUserUID = ClientService.getCurrentUserUID()
        let friendsOfCurrentUserRef = ClientService.friendsRef.child("\(currentUserUID)")
        
        
        
        //maybe this should be an if let else say "you're not logged in or there's no itnernet connection
        
        //1. check if friend is a user -DONE
        //2. if friend is a user go to a.DONE
        //3. if fiend is not a user go to b. DONE
        
        //A. if friend is a user:
        // 1. check if friend is already added to friends list
        // 2. if friend is already added to friends list, go to a.
        //         a. Alerts.showErrorMessage("Friend is already added to your friends list!")
        // 3. if friend is not yet added to friends list, go to b.
                    // b. add friend to friends list
                    //    c. Alerts.showSuccessMessage
        
        
        //1. if friend is already added to friends list, say that the friend is already added to friends list.
        //2. if
        
//        let friendsUserID =
//        
//        friendsCurrentUserRef.updateChildValues(<#T##values: [NSObject : AnyObject]##[NSObject : AnyObject]#>)
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

    
    
}
