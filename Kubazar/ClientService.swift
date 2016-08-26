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
    
    
    func checkIfUserExistsByEmailOrUsername(closure: String -> Void) {
        
    }
    
//    let user = FIRAuth.auth()?.currentUser
//    return user!.uid
    
  }
    
//
//    static func getCurrentUser() -> User {
//       
//        var name = String()
//        var email = String()
//        
//        if let user = FIRAuth.auth()?.currentUser {
//            
//            
//            name = user.displayName!
//            email = user.email!
////            let photoUrl = user.photoURL
////            let uid = user.uid;
//            // The user's ID, unique to the Firebase project.
//            // Do NOT use this value to authenticate with
//            // your backend server, if you have one. Use
//            // getTokenWithCompletion:completion: instead.
////        } else {
////            // No user is signed in.
////        }
//        
//        
//    }
//        
//        let currentUser = User(username: name, emailAddress: email)
//        
//        print(currentUser)
//        
//        return currentUser
//    }

}