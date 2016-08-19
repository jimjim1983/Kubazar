//
//  StartViewController.swift
//  Kubazar
//
//  Created by Alyson Vivattanapa on 7/13/16.
//  Copyright © 2016 Jimsalabim. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var twoFriendsButton: UIButton!
    
    @IBOutlet weak var threeFriendsButton: UIButton!
    
    @IBOutlet weak var createNewHaikuView: UIView!
    
    @IBOutlet weak var chooseFriendsView: UIView!

    @IBOutlet weak var choosePictureView: UIView!
    
    @IBOutlet weak var enterHaikuView: UIView!
    
    @IBOutlet weak var congratsView: UIView!
    // congratsView should take you to active bazar table view
    // table view selection goes to detail view that includes share button?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func twoFriendsButtonPressed(sender: AnyObject) {
        
        
    }
    
    
    @IBOutlet weak var threeFriendsButtonPressed: UIButton!
    



}
