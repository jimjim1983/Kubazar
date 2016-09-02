//
//  ClientService.swift
//  Kubazar
//
//  Created by Alyson Vivattanapa on 7/20/16.
//  Copyright © 2016 Jimsalabim. All rights reserved.
//

import Foundation
import Firebase

//BaseAPIService could be a better name
struct ClientService {
    
    static let rootRef = FIRDatabase.database().reference()
    
    // Database URL is automatically determined from GoogleService-Info.plist
    
    static let profileRef = rootRef.child("profile")
    
    static let activeHaikusRef = rootRef.child("activeHaikus")
    
    static let completedHaikusRef = rootRef.child("completedHaikus")
    
    static let friendsRef = rootRef.child("friends")
    
    static func getCurrentUser(closure: (FIRUser) -> Void) {
        
        if let user = FIRAuth.auth()?.currentUser {
        closure(user)
        } else {
             print("no user is currently logged in")
        }
        
    }
    
   static func getCurrentUserUID() -> String {
    
    
    if let user = FIRAuth.auth()?.currentUser {
        return user.uid } else {
        return "no user id"
    }
    }
    
    static func checkIfUserExistsByEmailOrUsername(closure: String -> Void) {
        
    }
    
    
    static func getFriendsForCurrentUser(currentUserUID: String) ->  [User] {
        
        var arrayOfUserFriends = [User]()
        var arrayOfUserFriendsUIDs = [String]()
//        friendsRef.child(currentUserUID).queryOrderedByKey().observeSingleEventOfType(.Value) { (snapshot) in
//            <#code#>
//        }
        
        friendsRef.child("\(currentUserUID)").queryOrderedByChild("key").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            for friend in snapshot.children {
                let uid = friend.value.objectForKey("uid") as! String
                arrayOfUserFriendsUIDs.append(uid)
            }
        })
        
        for uid in arrayOfUserFriendsUIDs {
            profileRef.child("\(uid)").queryOrderedByChild("key").observeSingleEventOfType(.Value, withBlock: { (friend) in
                let uid = friend.value?.objectForKey("uid") as! String
                let email = friend.value?.objectForKey("email") as! String
                let username = friend.value?.objectForKey("username") as! String
                let user = User(username: username, email: email, uid: uid)
                arrayOfUserFriends.append(user)
            })
        }
        return arrayOfUserFriends
    }
    
    
    
    static func getFriendUIDsForCurrentUser(closure: [String] -> Void) {
        
        let currentUserUiD = getCurrentUserUID()
        
        friendsRef.child("\(currentUserUiD)").queryOrderedByKey().observeEventType(.Value, withBlock: { snapshot in
            
            var friendUIDs = [String]()
            
            for item in snapshot.children {
                
                let friendUID = item.value.objectForKey("uid") as! String
                
                friendUIDs.append(friendUID)
            }
            
            //             print(users)
            
            closure(friendUIDs)
            
        })
        
    }

}