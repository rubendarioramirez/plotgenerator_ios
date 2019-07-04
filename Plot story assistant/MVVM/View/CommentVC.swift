//
//  CommentVC.swift
//  Plot story assistant
//
//  Created by webastral on 28/06/19.
//  Copyright © 2019 webastral. All rights reserved.
//

import UIKit
import SWRevealViewController
import Firebase
import IQKeyboardManagerSwift
class CommentVC: UIViewController {

    @IBOutlet weak var commentTableVew: UITableView!
    @IBOutlet weak var btnSideMenu: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtViewStory: UITextView!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var imgLikeUnlike: UIImageView!
    @IBOutlet weak var lblCommentCount: UILabel!
    @IBOutlet weak var txtViewComments: IQTextView!
    @IBOutlet weak var commentTableVewHeightConstraint: NSLayoutConstraint!
    
    // MARK:- Outlets
    var objViewModal = WeeklyParticipantViewModal()
    var objSubmitChallenge = SubmitYourChallengeVC()
    var selectedIndex = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTableVew.delegate = self
        commentTableVew.dataSource = self
        let revealVC = revealViewController()
        btnSideMenu.addTarget(revealVC, action: #selector(revealVC?.revealToggle(_:)), for: .touchUpInside)
//        self.view.addGestureRecognizer((revealVC?.panGestureRecognizer())!)
        self.popWithSwipe()
        setData()
    }
    
    func setData() {
        lblTitle.text = objViewModal.getTitle(index: selectedIndex)
        lblLikeCount.text = "\(objViewModal.getLikeCount(index: selectedIndex))"
        lblCommentCount.text = "\(objViewModal.getCommentCount(index: selectedIndex))"
        if let imgUrl = URL(string: objViewModal.getProfileImg(index: selectedIndex)){
            imgProfile.kf.setImage(with: imgUrl)
        }
        txtViewStory.text = objViewModal.getChallenge(index: selectedIndex)
        if objViewModal.getPostIsLiked(index: selectedIndex){
            self.imgLikeUnlike.image = UIImage(named: "Like")
        }else{
            self.imgLikeUnlike.image = UIImage(named: "Unlike")
        }
        
        print(objViewModal.getCommentCount(index: selectedIndex))
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @IBAction func btnLikeUnlike(_ sender: UIButton) {
        if imgLikeUnlike.image == UIImage(named: "Like"){
            likeUnlikePost(false)
        }else{
            likeUnlikePost(true)
        }
    
    }
    
    func likeUnlikePost(_ status:Bool) {
       
        let postId = objViewModal.getPostId(index: selectedIndex)
        var dict = objViewModal.getLikes(index: selectedIndex)
        var likeCount = self.objViewModal.getLikeCount(index: self.selectedIndex)
        
        if status{
            dict[Auth.auth().currentUser?.uid ?? ""] = true
            likeCount += 1
        }else{
            dict.removeValue(forKey: Auth.auth().currentUser?.uid ?? "")
            likeCount -= 1
        }
    UtilityMgr.fireStoreDB.collection("Weekly_Challenge_Beta_1").document("posts").collection("posts").document(postId).updateData([
            "likes":dict,
            "likeCount": likeCount
        ]) { err in
            if let err = err{
                print("Error updating document: \(err.localizedDescription)")
            }else{
    
                self.objViewModal.setIsLiked(index: self.selectedIndex, value: status)
                self.objViewModal.setLikeCount(index: self.selectedIndex, value: likeCount)
                self.setData()
                
                print("Document successfully updated")
            }
        }
    }
    
    // MARK:- Button Action
    
    
    @IBAction func btnPostAction(_ sender: UIButton) {
        
      let ref = UtilityMgr.fireStoreDB.collection("Weekly_Challenge_Beta_1").document("post-comments").collection("post-comments").document(objViewModal.getPostId(index: selectedIndex)).collection("Comments").document(Auth.auth().currentUser?.uid ?? "")
        print(ref.path)
        
        let commentDict = ["userComment":txtViewComments.text,
                           "userDate":Date.timeIntervalSinceReferenceDate,
                           "userId":Auth.auth().currentUser?.uid ?? "",
                           "userName":UtilityMgr.LoginUserDecodedDetail().fullName,
                           "userPic":UtilityMgr.LoginUserDecodedDetail().imageUrl
            ] as [String : Any]
        
        UtilityMgr.fireStoreDB.collection("Weekly_Challenge_Beta_1").document("post-comments").collection("post-comments").document(objViewModal.getPostId(index: selectedIndex)).collection("Comments").document().setData( commentDict
            
        ){ err in
            if err == nil{
                print("Data Saved")
                self.txtViewComments.text = ""
                print(ref.documentID)
                self.objViewModal.insertNewComment(dict: commentDict, index: self.selectedIndex)
                self.lblCommentCount.text = "\(self.objViewModal.getCommentCount(index: self.selectedIndex))"
                self.commentTableVew.reloadData()
            }else{
                print(err?.localizedDescription)
            }
        }
    }
}
    

extension CommentVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objViewModal.getCommentCount(index: selectedIndex)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentTableVew.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! CommentVCCell
        cell.lblUserName.text = objViewModal.getUserCommentName(index: selectedIndex, subIndex: indexPath.row)
        cell.lblCommentDesc.text = objViewModal.getUserComment(index: selectedIndex, subIndex: indexPath.row)
        if let imgUrl = URL(string: objViewModal.getUserCommentPic(index: selectedIndex, subIndex: indexPath.row))
        {
            cell.imgProfile.kf.setImage(with: imgUrl)
        }
        commentTableVewHeightConstraint.constant = self.commentTableVew.contentSize.height
        cell.backgroundColor = .clear
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
