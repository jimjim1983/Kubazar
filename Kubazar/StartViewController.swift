//
//  StartViewController.swift
//  Kubazar
//
//  Created by Alyson Vivattanapa on 7/13/16.
//  Copyright © 2016 Jimsalabim. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
    
    @IBOutlet weak var haikuImageView: UIImageView!
    
    
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
    
    @IBAction func continueButtonPressed(sender: AnyObject) {
        stepThreeChoosePicture()
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
    
    @IBAction func cameraButtonPressed(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func cameraRollButtonPressed(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        haikuImageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil);
        stepFourEnterHaiku()
    }


}
