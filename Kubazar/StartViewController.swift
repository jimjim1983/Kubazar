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
    
    @IBOutlet weak var choosePictureView: UIView!

    @IBOutlet weak var chooseFriendsView: UIView!
 
    @IBOutlet weak var chooseFriendsLabel: UILabel!
    
    @IBOutlet weak var enterHaikuView: UIView!
    
    @IBOutlet weak var congratsView: UIView!
    // congratsView should take you to active bazar table view
    // table view selection goes to detail view that includes share button?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        stepOneCreateNewHaiku()
        // Do any additional setup after loading the view.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func stepOneCreateNewHaiku() {
        createNewHaikuView.alpha = 1
        chooseFriendsView.alpha = 0
        choosePictureView.alpha = 0
        enterHaikuView.alpha = 0
        congratsView.alpha = 0
    }
    
    func stepTwoChooseFriends() {
        createNewHaikuView.alpha = 0
        chooseFriendsView.alpha = 1
        choosePictureView.alpha = 0
        enterHaikuView.alpha = 0
        congratsView.alpha = 0
    }
    
    func stepThreeChoosePicture() {
        createNewHaikuView.alpha = 0
        chooseFriendsView.alpha = 0
        choosePictureView.alpha = 1
        enterHaikuView.alpha = 0
        congratsView.alpha = 0
    }
    
    func stepFourEnterHaiku() {
        createNewHaikuView.alpha = 0
        chooseFriendsView.alpha = 0
        choosePictureView.alpha = 0
        enterHaikuView.alpha = 1
        congratsView.alpha = 0
    }
    
    func stepFiveCongrats() {
        createNewHaikuView.alpha = 0
        chooseFriendsView.alpha = 0
        choosePictureView.alpha = 0
        enterHaikuView.alpha = 0
        congratsView.alpha = 1
    }
    
    @IBAction func startOverButtonPressed(sender: AnyObject) {
        stepOneCreateNewHaiku()
    }
    
    @IBAction func twoFriendsButtonPressed(sender: AnyObject) {
        
        chooseFriendsLabel.text = "Choose a friend!"
        stepTwoChooseFriends()
        
    }
    

    @IBAction func threeFriendsButtonPressed(sender: AnyObject) {
        
        chooseFriendsLabel.text = "Choose two friends!"
        stepTwoChooseFriends()
        
    }


}
