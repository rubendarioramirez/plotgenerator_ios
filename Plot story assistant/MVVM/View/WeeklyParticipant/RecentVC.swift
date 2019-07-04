//
//  RecentVC.swift
//  Plot story assistant
//
//  Created by webastral on 26/06/19.
//  Copyright © 2019 webastral. All rights reserved.
//

import UIKit

class RecentVC: UIViewController {

    @IBOutlet weak var tableVew: UITableView!
    
    //MARK:- Outlets
    let objWeeklyParticpantViewModel = WeeklyParticipantViewModal()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVew.delegate = self
        tableVew.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(yourfunction(notfication:)), name: Notification.Name("postNotifi"), object: nil)

        objWeeklyParticpantViewModel.weeklyParticipantRecent { (success) in
            if success{
                self.tableVew.reloadData()
            }else{
                print("Error Occured")
            }
        }
    }
    
    @objc func yourfunction(notfication: NSNotification) {

        if let dict = notfication.userInfo as? [String:Any]{
            if dict["catagory"]as? String ?? "" == "1"{
                objWeeklyParticpantViewModel.setArrayData(Catagory: "Recent")
                self.tableVew.reloadData()
            }
        }
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        tableVew.reloadData()
//    }

}
extension RecentVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objWeeklyParticpantViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVew.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! RecentVCCell
        
        cell.lblProfileName.text = objWeeklyParticpantViewModel.getName(index: indexPath.row)
        if let imgUrl = URL(string: objWeeklyParticpantViewModel.getProfileImg(index: indexPath.row)){
            cell.imgProfilePIc.kf.setImage(with: imgUrl)
        }
        if objWeeklyParticpantViewModel.getPostIsLiked(index: indexPath.row){
            cell.imgLikeUnlike.image = UIImage(named: "Like")
        }else{
            cell.imgLikeUnlike.image = UIImage(named: "Unlike")
        }
        cell.lblTitle.text = objWeeklyParticpantViewModel.getTitle(index: indexPath.row)
        cell.lblStory.text = objWeeklyParticpantViewModel.getChallenge(index: indexPath.row)
        cell.lblLikeCount.text = "\(objWeeklyParticpantViewModel.getLikeCount(index: indexPath.row))"
        cell.lblCommentCount.text = "\(objWeeklyParticpantViewModel.getCommentCount(index: indexPath.row))"
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CommentVC")as! CommentVC
        vc.objViewModal = objWeeklyParticpantViewModel
        vc.selectedIndex = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

