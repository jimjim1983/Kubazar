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
        
//        inviteNewFriendsViewSetup()
        
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
        inviteNewFriendsButton.alpha = 1
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
                
                ClientService.profileRef.queryOrderedByChild("email").queryEqualToValue(friendsEmailText).observeSingleEventOfType(.ChildAdded, withBlock: { (snapshot) in
                    
                    
                    if snapshot.exists() {
                        
                        let friendUID = snapshot.value?.objectForKey("uid") as! String
                        
                        
                        
                        print(snapshot.value)
                        
                       print(snapshot)
                        
                        print("user exists")
                   
                        
//                       print(snapshot.valueForUndefinedKey("uid"))
                        
//                        print(snapshot.value?.objectForKey("uid"))
//                        
//                        let friendUID = snapshot.value?.
//                       
                       self.addExistingUserAsFriend(friendUID, email: friendsEmailText)
                        
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
    
    func addExistingUserAsFriend(friendUID: String, email: String) {
        
        let currentUserUID = ClientService.getCurrentUserUID()
        let currentUserFriendsRef = ClientService.friendsRef.child("\(currentUserUID)")
        
        
//        if friendUID == currentUserUID {
//            self.presentViewController(Alerts.showErrorMessage("Sorry! You can't be friends with yourself for Kubazar."), animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
//        }
        
        currentUserFriendsRef.queryOrderedByChild("key").queryEqualToValue(friendUID).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            if snapshot.exists() {
                
                self.presentViewController(Alerts.showErrorMessage("This friend is already added to your friend list!"), animated: true, completion: nil)
                
            } else {
                
                currentUserFriendsRef.child("\(friendUID)/email").setValue(email)
                
//                ClientService.profileRef.child("\(uid)/username").setValue(signupUsername)
//                
            }
            
        })
        
        
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
