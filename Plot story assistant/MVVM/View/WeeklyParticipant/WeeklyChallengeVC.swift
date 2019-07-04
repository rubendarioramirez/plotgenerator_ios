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
import GoogleSignIn
import FirebaseFirestore

class WeeklyChallengeVC: UIViewController,UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate ,SocialLoginDelegate{

    @IBOutlet weak var btnViewAds: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    var ref: DatabaseReference!
    var composeVC : MFMailComposeViewController?
    var weeklyChallenge = Array<String>()
    
    typealias completion = (NSDictionary?,Int?,Int?)->()
    
    var socialLogin = SocialLogin()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         socialLogin.delegate = self
//        let documentReference : DocumentReference?
//
//        documentReference = UtilityMgr.fireStoreDB.collection("weekly_winners").document()
//        print(documentReference?.documentID)

        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("rewardAD"), object: nil)
        // Do any additional setup after loading the view.
        
        tblView.dataSource = self
        tblView.delegate = self
       WeeklychallengeViewModel.shared().weeklyOnGoingChallenge(topView: self, tblView: tblView)
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
    
    @IBAction func btnParicipateAction(_ sender: UIButton) {
        if sender.currentTitle == "Participate"{
            if UtilityMgr.LoginUserDecodedDetail().email != ""{
                let vc = storyboard?.instantiateViewController(withIdentifier: "SubmitYourChallengeVC")as! SubmitYourChallengeVC
                vc.storyTitle =  WeeklychallengeViewModel.shared().objWeeklyOnGoingChallengeModel.title ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else{
                 socialLogin.googleSignIn()
            }
        }else{
                WeeklychallengeViewModel.shared().btnViewAd(btnViewAds: btnViewAds, topView: self)
        }
    }
    
    @IBAction func btnReadAction(_ sender: Any) {
       if UtilityMgr.LoginUserDecodedDetail().authToken != ""{
           let vc = storyboard?.instantiateViewController(withIdentifier: "WeeklyChallengedParticipantVC")as! WeeklyChallengedParticipantVC
        let objMyStory = MyStoryVC()
        
        
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
             if UtilityMgr.LoginUserDecodedDetail().authToken != ""{
            pushController(indentifier: "WeeklyChallengedParticipantVC")
             }else{
                socialLogin.googleSignIn()
            }
        }
    }
    
   
    func googleSignedIn(data:[String:Any]?,error:Error?){
        if error == nil{
//            pushController(indentifier: "WeeklyChallengedParticipantVC")
        }else{
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return WeeklychallengeViewModel.shared().cellForRowAtIndex(tableView:tableView,indexPath:indexPath, topView: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return WeeklychallengeViewModel.shared().getHeightWeekly(indexPath:indexPath)
    }
  

}
