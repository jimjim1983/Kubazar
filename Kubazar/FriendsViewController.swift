//
//  FriendsViewController.swift
//  Kubazar
//
//  Created by Alyson Vivattanapa on 7/13/16.
//  Copyright © 2016 Jimsalabim. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var xButton: UIButton!
    
    @IBOutlet weak var friendsTableView: UITableView!
    
    @IBOutlet weak var inviteNewFriendsView: UIView!
    
    @IBOutlet weak var friendsEmailTextField: UITextField!

    @IBOutlet weak var inviteNewFriendsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       friendsEmailTextField.delegate = self

        // Do any additional setup after loading the view.
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
        xButton.alpha = 0
    }
    
    
    @IBAction func xButtonPressed(sender: AnyObject) {
        xButton.alpha = 0
        inviteNewFriendsView.alpha = 0
        inviteNewFriendsButton.alpha = 1
        friendsEmailTextField.text? = ""
        
    }
    
    @IBAction func inviteNewFriendsButtonPressed(sender: AnyObject) {
        
//        inviteNewFriendsView.layer.cornerRadius = 33
        
//        xButton.layer.cornerRadius = 1
        inviteNewFriendsView.alpha = 1
        xButton.alpha = 1
        inviteNewFriendsButton.alpha = 0
        
    }
    
    func isValidEmail(emailStr: String) -> Bool {
        if emailStr.containsString("@") {
            return true
        } else {
            return false
        }
    }
    

    
    func addFriend() {
        
        //maybe this should be an if let else say "you're not logged in or there's no itnernet connection
        
        let currentUserUID = ClientService.getCurrentUserUID()
        
        let friendsOfCurrentUserRef = ClientService.friendsRef.child("\(currentUserUID)")
        
        
        
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
