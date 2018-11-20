//
//  WeeklyChallengeVC.swift
//  Plot story assistant
//
//  Created by webastral on 11/3/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import GoogleMobileAds
import MessageUI


class WeeklyChallengeVC: UIViewController,UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate {

    @IBOutlet weak var btnViewAds: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    var ref: DatabaseReference!
    var composeVC : MFMailComposeViewController?
    var weeklyChallenge = Array<String>()
    
    
    var objWeeklyChallengeViewModel = WeeklychallengeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("rewardAD"), object: nil)
        // Do any additional setup after loading the view.
        
        tblView.dataSource = self
        tblView.delegate = self
      
        tblView.estimatedRowHeight = 44
        tblView.rowHeight = UITableViewAutomaticDimension
        
        sideMenu = self.revealViewController()
        sideMenu.tapGestureRecognizer().isEnabled = true
        
        objWeeklyChallengeViewModel.weeklyChallenge(topView: self, tblView: tblView)
    }
    
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        btnViewAds.setTitle("Participate", for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnSideMenuAction(_ sender: Any) {
        sideMenu.revealToggle(animated: true)
    }
    
    
    @IBAction func btnParicipateAction(_ sender: Any) {
       objWeeklyChallengeViewModel.btnViewAd(btnViewAds: btnViewAds, topView: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objWeeklyChallengeViewModel.weeklyChallenge.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       return objWeeklyChallengeViewModel.cellForRowAtIndex(tableView:tableView,indexPath:indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
  
    

    
}
