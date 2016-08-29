//
//  StartViewController.swift
//  Kubazar
//
//  Created by Alyson Vivattanapa on 7/13/16.
//  Copyright © 2016 Jimsalabim. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    
    
    @IBOutlet weak var secondBackButton: UIButton!
    
    @IBOutlet weak var imageViewBoundary: UIImageView!
    
    @IBOutlet weak var firstKubazarMascot: UIImageView!
    
    @IBOutlet weak var twoFriendsButton: UIButton!
    
    @IBOutlet weak var threeFriendsButton: UIButton!
    
    @IBOutlet weak var createNewHaikuView: UIView!
    
    @IBOutlet weak var createNewHaikuLabel: UILabel!
    
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
    
    var animator: UIDynamicAnimator!
    
    var gravity: UIGravityBehavior!
    
    var collision: UICollisionBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    haikuFirstLine.delegate = self
        
    haikuSecondLine.delegate = self
        
    haikuThirdLine.delegate = self
        
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WelcomeViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WelcomeViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)

        
    stepOneCreateNewHaiku()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func stepOneCreateNewHaiku() {
       
        twoFriendsButton.transform = CGAffineTransformMakeScale(0.7, 0.7)
        threeFriendsButton.transform = CGAffineTransformMakeScale(0.7, 0.7)
        
        setAllViewAlphasToZero()
        createNewHaikuView.alpha = 1
       
        animator = UIDynamicAnimator(referenceView: self.createNewHaikuView)
        gravity = UIGravityBehavior(items: [firstKubazarMascot])
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [firstKubazarMascot])
        collision.addBoundaryWithIdentifier("createNewHaikuLabel", forPath: UIBezierPath(rect: createNewHaikuLabel.frame))
        
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        let itemBehavior = UIDynamicItemBehavior(items: [firstKubazarMascot])
        itemBehavior.elasticity = 0.7
        animator.addBehavior(itemBehavior)
        
        UIView.animateWithDuration(1.6, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 9, options: .AllowUserInteraction, animations: {
            self.twoFriendsButton.transform = CGAffineTransformIdentity
            self.threeFriendsButton.transform = CGAffineTransformIdentity
            }, completion: nil)
        
    }
    
    func stepTwoChooseOneFriend () {
        setAllViewAlphasToZero()
        chooseFriendsView.alpha = 1
        
        haikuSecondLine.placeholder = "Second player writes here."
        
        haikuSecondLine.userInteractionEnabled = false
        
        haikuThirdLine.placeholder =
            
        "enter last line"
    }
    
    func stepTwoChooseTwoFriends () {
        setAllViewAlphasToZero()
        chooseFriendsView.alpha = 1
       
        haikuSecondLine.placeholder = "Second player writes here."
        
        haikuSecondLine.userInteractionEnabled = false
        
        haikuThirdLine.placeholder =
            
        "Third player writes here."
        
        haikuThirdLine.userInteractionEnabled = false
    }
    
    //refactor these steps functions, pass view to show
    //hide all views function
    
    
    func stepThreeChoosePicture() {
        setAllViewAlphasToZero()
        choosePictureView.alpha = 1
    }
    
    func stepFourEnterHaiku() {
        setAllViewAlphasToZero()
        enterHaikuView.alpha = 1
    }
    
    func stepFiveCongrats() {
        setAllViewAlphasToZero()
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
    
    
    @IBAction func secondBackButtonPressed(sender: AnyObject) {
        setAllViewAlphasToZero()
        chooseFriendsView.alpha = 1
        
    }
    
    @IBAction func thirdBackButtonPressed(sender: AnyObject) {
        haikuFirstLine.text? = ""
        haikuSecondLine.text? = ""
        haikuThirdLine.text? = ""
        setAllViewAlphasToZero()
        choosePictureView.alpha = 1
    }
    
    
    func setAllViewAlphasToZero() {
        createNewHaikuView.alpha = 0
        chooseFriendsView.alpha = 0
        choosePictureView.alpha = 0
        enterHaikuView.alpha = 0
        congratsView.alpha = 0
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

    //keyboard code
    
    
    //textfield delegate
    
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
