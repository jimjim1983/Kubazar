//
//  StartViewController.swift
//  Kubazar
//
//  Created by Alyson Vivattanapa on 7/13/16.
//  Copyright © 2016 Jimsalabim. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
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
    
    @IBOutlet weak var haikuFirstLine: UITextField!
    
    @IBOutlet weak var haikuSecondLine: UITextField!
    
    @IBOutlet weak var haikuThirdLine: UITextField!
    
    
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
    
    func stepTwoChooseOneFriend () {
        createNewHaikuView.alpha = 0
        chooseFriendsView.alpha = 1
        choosePictureView.alpha = 0
        enterHaikuView.alpha = 0
        congratsView.alpha = 0
        
        haikuSecondLine.placeholder = "Second player writes here."
        
        haikuSecondLine.userInteractionEnabled = false
        
        haikuThirdLine.placeholder =
            
        "enter last line"
    }
    
    func stepTwoChooseTwoFriends () {
        createNewHaikuView.alpha = 0
        chooseFriendsView.alpha = 1
        choosePictureView.alpha = 0
        enterHaikuView.alpha = 0
        congratsView.alpha = 0
        
        haikuSecondLine.placeholder = "Second player writes here."
        
        haikuSecondLine.userInteractionEnabled = false
        
        haikuThirdLine.placeholder =
            
        "Third player writes here."
        
        haikuThirdLine.userInteractionEnabled = false
    }
    
    //refactor these steps functions, pass view to show
    //hide all views function
    
    
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
        
        stepTwoChooseOneFriend()

    }
    

    @IBAction func threeFriendsButtonPressed(sender: AnyObject) {
        
        chooseFriendsLabel.text = "Choose two friends!"
        
        stepTwoChooseTwoFriends()
        
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
    
    @IBAction func inspireMeButtonPressed(sender: AnyObject) {
        
// cannot specify custom source type for image picker. may have to implement collection view and choose images from database in collection view. for now, button does nothing!

    }
    

    @IBAction func startButtonPressed(sender: AnyObject) {
        
        /*
         
         save image example code, write to Firebase somehow?:
         
         var imageData = UIImageJPEGRepresentation(imagePicked.image, 0.6)
         var compressedJPGImage = UIImage(data: imageData)
         UIImageWriteToSavedPhotosAlbum(compressedJPGImage, nil, nil, nil)
         
         */
        
        //save active haiku to firebase...model object? gahh...first player, second player, third player OR first player, second player, third player = first player
    
    }
    
    //textfield delegate 
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    // write haiku to Firebase...Firebase generates unique ID for each haiku post:
    /*
 let postRef = ref.childByAppendingPath("posts")
 let post1 = ["author": "gracehop", "title": "Announcing COBOL, a New Programming Language"]
 let post1Ref = postRef.childByAutoId()
 post1Ref.setValue(post1)
 
 let post2 = ["author": "alanisawesome", "title": "The Turing Machine"]
 let post2Ref = postRef.childByAutoId()
 post2Ref.setValue(post2)
     
 postID = post1Ref.key 
  // calling .key gets the unique ID of that post
 */

}
