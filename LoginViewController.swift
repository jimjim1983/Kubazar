//
//  LoginViewController.swift
//  Kubazar
//
//  Created by Alyson Vivattanapa on 6/16/16.
//  Copyright © 2016 Jimsalabim. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        if FBSDKAccessToken.currentAccessToken() != nil {
            let startGameVC = StartGameViewController()
            presentViewController(startGameVC, animated: true, completion: nil)
        }
    }
    
    func setupView() {
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.center = CGPointMake(screenWidth/2, screenHeight/1.5)
        
        let kubazarMascotImage = UIImage(named: "kubazarMascot")
        let kubazarMascotImageView = UIImageView(image: kubazarMascotImage)
        kubazarMascotImageView.frame = CGRect(x: 0, y: 0, width: screenWidth/2, height: screenHeight/3)
        kubazarMascotImageView.center = CGPointMake(screenWidth/2, screenHeight/3)
        kubazarMascotImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        self.view.addSubview(loginButton)
        self.view.addSubview(kubazarMascotImageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
