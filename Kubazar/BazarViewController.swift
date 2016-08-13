//
//  BazarViewController.swift
//  Kubazar
//
//  Created by Alyson Vivattanapa on 7/13/16.
//  Copyright © 2016 Jimsalabim. All rights reserved.
//

import UIKit

class BazarViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var activeView: UIView!
    
    @IBOutlet weak var completedView: UIView!
    
    @IBOutlet weak var activeTableView: UITableView!
    
    @IBOutlet weak var completedTableView: UITableView!
    
    struct PreviewDetail {
        let title: String
        let preferredHeight: Double
    }
    
    let sampleData = [
        PreviewDetail(title: "Small", preferredHeight: 160.0),
        PreviewDetail(title: "Medium", preferredHeight: 320.0),
        PreviewDetail(title: "Large", preferredHeight: 0.0) // 0.0 to get the default height.
    ]
    
    let sampleData1 = [
        PreviewDetail(title: "One", preferredHeight: 160.0),
        PreviewDetail(title: "Two", preferredHeight: 320.0),
        PreviewDetail(title: "Three", preferredHeight: 0.0), // 0.0 to get the default height.
        PreviewDetail(title: "More", preferredHeight: 0.0) // 0.0 to get the default height.
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ClientService.getCurrentUser { (currentUser) in
            print("hello hello \(currentUser.uid)")
        }
//        print("hello hello \(ClientService.getCurrentUserUID())")
        
        activeTableView.dataSource = self
        
        activeTableView.delegate = self
        
        let activeNib = UINib.init(nibName: "ActiveHaikusTableViewCell", bundle: nil)
        self.activeTableView.registerNib(activeNib, forCellReuseIdentifier: "activeCell")
        
        completedTableView.dataSource = self
        
        completedTableView.delegate = self
        
        let completedNib = UINib.init(nibName: "CompletedHaikusTableViewCell", bundle: nil)
        self.completedTableView.registerNib(completedNib, forCellReuseIdentifier: "completedCell")

        
// if activeHaikus || completedHaikus path does not contain current user UID string path, then { activeView and completedView alphas are set to 0 and 
        
        self.segmentedControl.selectedSegmentIndex = 0
        activeView.alpha = 1
        completedView.alpha = 0
        
    }

   
    @IBAction func segmentedControlIndexChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            // show active
            activeView.alpha = 1
            completedView.alpha = 0
        case 1:
            //show Completed
            completedView.alpha = 1
            activeView.alpha = 0
        default:
            
            break
        }
    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int?
        
        if tableView == self.activeTableView {
            count = sampleData.count
        }
        
        if tableView == self.completedTableView {
            count = sampleData1.count
        }
        
        return count!
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        
        if tableView == self.activeTableView {
            cell = tableView.dequeueReusableCellWithIdentifier("activeCell", forIndexPath: indexPath) as! ActiveHaikusTableViewCell
            let previewDetail = sampleData[indexPath.row]
            cell!.textLabel?.text = previewDetail.title
        }
    
        if tableView == self.completedTableView {
            cell = tableView.dequeueReusableCellWithIdentifier("completedCell", forIndexPath: indexPath) as! CompletedHaikusTableViewCell
            let previewDetail = sampleData1[indexPath.row]
            cell!.textLabel?.text = previewDetail.title
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("did select: \(indexPath.row)")
    }
    
}
