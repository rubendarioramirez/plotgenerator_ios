//
//  MostVotedVC.swift
//  Plot story assistant
//
//  Created by webastral on 26/06/19.
//  Copyright © 2019 webastral. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Kingfisher
class MostVotedVC: UIViewController {

    @IBOutlet weak var tableVew: UITableView!
    
    var objViewModal = WeeklyParticipantViewModal()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVew.delegate = self
        tableVew.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(yourfunction(notfication:)), name: Notification.Name("postNotifi"), object: nil)

        objViewModal.weeklyParticipantMostVoted { (success) in
            if success{
                self.tableVew.reloadData()
            }else{
                
            }
        }
    }
    
    @objc func yourfunction(notfication: NSNotification) {
        if let dict = notfication.userInfo as? [String:Any]{
            if dict["catagory"]as? String ?? "" == "0"{
                objViewModal.setArrayData(Catagory: "Most")
                self.tableVew.reloadData()
            }
        }
    }
    
}
extension MostVotedVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return objViewModal.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVew.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! MostViewVCCell
        cell.lblProfileName.text = objViewModal.getName(index: indexPath.row)
        if let imgUrl = URL(string: objViewModal.getProfileImg(index: indexPath.row)){
            cell.imgProfilePIc.kf.setImage(with: imgUrl)
        }
        if objViewModal.getPostIsLiked(index: indexPath.row){
            cell.imgLikeUnlike.image = UIImage(named: "Like")
        }else{
            cell.imgLikeUnlike.image = UIImage(named: "Unlike")
        }
        cell.lblTitle.text = objViewModal.getTitle(index: indexPath.row)
        cell.lblStory.text = objViewModal.getChallenge(index: indexPath.row)
        cell.lblLikeCount.text = "\(objViewModal.getLikeCount(index: indexPath.row))"
        cell.lblCommentCount.text = "\(objViewModal.getCommentCount(index: indexPath.row))"
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CommentVC")as! CommentVC
        vc.objViewModal = objViewModal
        vc.selectedIndex = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
}