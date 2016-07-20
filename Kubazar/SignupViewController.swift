//
//  SignupViewController.swift
//  Kubazar
//
//  Created by Alyson Vivattanapa on 7/13/16.
//  Copyright © 2016 Jimsalabim. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var thirdView: UIView!
    
    var timer = NSTimer()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        secondView.alpha = 0
        
        thirdView.alpha = 0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func firstContinueButtonPressed(sender: AnyObject) {
        
        firstView.alpha = 0
        secondView.alpha = 1
    }
    
  
    @IBAction func secondContinueButtonPressed(sender: AnyObject) {
        
        secondView.alpha = 0
        thirdView.alpha = 1
        
        timer = NSTimer.init(timeInterval: 1.0, target: self, selector: #selector(SignupViewController.loadKubazar), userInfo: nil, repeats: false)
        
    }
    
    func loadKubazar() {
        //tabbar controller// app delegate
    }
    


}
