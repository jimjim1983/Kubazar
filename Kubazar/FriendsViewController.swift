//
//  FriendsViewController.swift
//  Kubazar
//
//  Created by Alyson Vivattanapa on 7/13/16.
//  Copyright © 2016 Jimsalabim. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {
    
    @IBOutlet weak var friendsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //table view for friends list
    
    //add new friend
    
    //duplicate data?

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    func addFriend() {
        
        //maybe this should be an if let else say "you're not logged in or there's no itnernet connection
        
        let currentUserUID = ClientService.getCurrentUserUID()
        
        let friendsOfCurrentUserRef = ClientService.friendsRef.child("\(currentUserUID)")
        
        
        
//        let friendsUserID =
//        
//        friendsCurrentUserRef.updateChildValues(<#T##values: [NSObject : AnyObject]##[NSObject : AnyObject]#>)
    }
    
    
}
