//
//  ClientService.swift
//  Kubazar
//
//  Created by Alyson Vivattanapa on 7/20/16.
//  Copyright © 2016 Jimsalabim. All rights reserved.
//

import Foundation
import Firebase

struct ClientService {
    
    static let rootRef = FIRDatabase.database().reference()
    
    static let usersRef = rootRef.child("users")
    
    static let activeHaikusRef = rootRef.child("activeHaikus")
    
    static let completedHaikusRef = rootRef.child("completedHaikus")
//    
//    static func getCurrentUser
}