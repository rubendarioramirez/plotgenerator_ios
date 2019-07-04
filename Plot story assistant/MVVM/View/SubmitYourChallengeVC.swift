//
//  SubmitYourChallengeVC.swift
//  Plot story assistant
//
//  Created by webastral on 01/07/19.
//  Copyright © 2019 webastral. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase

class SubmitYourChallengeVC: UIViewController,UITextViewDelegate {

    @IBOutlet weak var btnSideMenu: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtViewStory: IQTextView!
    @IBOutlet weak var lblStoryHeightConstraint: NSLayoutConstraint!
    
    
    //MARK:- Outlets
    var storyTitle:String = ""
    var userProfilePic:String = ""
    var date = Date()
    let calendar = Calendar.current
    var id :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtViewStory.delegate = self
        lblStoryHeightConstraint.constant = 0
        
        let revealVC = revealViewController()
        btnSideMenu.addTarget(revealVC, action:#selector(revealVC?.revealToggle(_:)) , for: .touchUpInside)
        self.view.addGestureRecognizer((revealVC?.panGestureRecognizer())!)
       lblUserName.text = UtilityMgr.LoginUserDecodedDetail().fullName
        lblTitle.text = storyTitle
        userProfilePic = UtilityMgr.LoginUserDecodedDetail().imageUrl
        
//        let hour = calendar.component(.hour, from: date)
//        let minutes = calendar.component(.minute, from: date)
        
    }
    
    //MARK:- Button Actions
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        self.id = UtilityMgr.fireStoreDB.collection("Weekly_Challenge_Beta_1").document("posts").collection("posts").document().documentID
        
        print(id)
        
        UtilityMgr.fireStoreDB.collection("Weekly_Challenge_Beta_1").document("posts").collection("posts").document(id).setData(
            ["chalenge":self.txtViewStory.text,
             "date":date.timeIntervalSinceReferenceDate,
             "genre":"",
             "id":id,
             "likeCount":0,
             "likes":[:],
             "title":self.lblTitle.text ?? "",
             "user":["email":UtilityMgr.LoginUserDecodedDetail().email,
                     "name":UtilityMgr.LoginUserDecodedDetail().fullName,
                     "picUrl":nil,"uid":Auth.auth().currentUser?.uid,
                     "uriString":UtilityMgr.LoginUserDecodedDetail().imageUrl]
            ]
        ) { (err) in
            if err == nil{
                print("Data Saved Successfully")
                self.navigationController?.popViewController(animated: true)
            }else{
                print(err?.localizedDescription)
            }
        }
    }
    
    //MARK:- TextView Delegate
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 0{
            UIView.animate(withDuration: 0.1) {
                self.lblStoryHeightConstraint.constant = 20
                self.view.layoutIfNeeded()
            }
        }else{
            UIView.animate(withDuration: 0.1) {
                self.lblStoryHeightConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }

}
