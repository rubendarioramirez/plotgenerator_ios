//
//  WeeklychallengeViewModel.swift
//  Plot story assistant
//
//  Created by webastral on 11/19/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import GoogleMobileAds
import MessageUI
import FirebaseFirestore
class WeeklychallengeViewModel: NSObject,MFMailComposeViewControllerDelegate  {
    
    
    static func shared()->WeeklychallengeViewModel{
        struct Shared{
            static let manager = WeeklychallengeViewModel()
        }
        return Shared.manager
    }
    
    
    var ref: DatabaseReference!
    var composeVC : MFMailComposeViewController?
    var weeklyChallenge = Array<String>()
    var objWeeklyOnGoingChallengeModel = WeeklyChallengedModel()
    var objWeeklyLastWinnerChallengeModel = WeeklyChallengedModel()
    
    var getBodyHeightVariable : CGFloat = 0
    var getTitleHeightVariable : CGFloat = 60
    

    func weeklyOnGoingChallenge(topView:UIViewController,tblView:UITableView){
        if Connectivity.isConnectedToInternet(){
        topView.showactivityIndicator()
        UtilityMgr.fireStoreDB.collection("weekly_challenge").document("current").getDocument { (snapshot, error) in
            topView.hideactivityIndicator()
            if error == nil{
                self.objWeeklyOnGoingChallengeModel.addData(dict: snapshot?.data() ?? ["":""])
                tblView.reloadData()
            }else{
                self.showAlert(msg:error?.localizedDescription ?? "Something went wrong")
            }
          }
        }else{
           showAlert(msg:UtilityMgr.internetString)
        }
    }
    
    func weeklyLastWinnerChallenge(topView:UIViewController,tblView:UITableView){
        if Connectivity.isConnectedToInternet(){
            UtilityMgr.fireStoreDB.collection("weekly_winners").document("current").getDocument { (snapshot, error) in
                print(snapshot?.data())
                if error == nil{
                    self.objWeeklyLastWinnerChallengeModel.addData(dict: snapshot?.data() ?? ["":""])
                tblView.reloadData()
                }else{
                    self.showAlert(msg:error?.localizedDescription ?? "Something went wrong")
                }
            }
        }else{
            showAlert(msg:UtilityMgr.internetString)
        }

    }
    
    func showAlert(msg:String){
        UtilityMgr.displayAlert(title: "", message: msg, control: ["OK"])
    }
    
    func cellForRowAtIndex(tableView:UITableView,indexPath:IndexPath,topView:UIViewController)->UITableViewCell{
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeeklyChallengeTVC
            cell.lblChallengeTitle.text = objWeeklyOnGoingChallengeModel.title ?? ""
             getTitleHeightVariable = CGFloat(objWeeklyOnGoingChallengeModel.title?.height(constraintedWidth: cell.lblChallengeTitle.frame.width , font: UIFont(name: "Typewriter_Condensed", size: 20)!) ?? 30.0)
            print("getTitleHeightVariable",getTitleHeightVariable)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDesc", for: indexPath) as! WeeklyChallengeTVC
        cell.lblChallengeDesc.text = objWeeklyOnGoingChallengeModel.body ?? ""
        getBodyHeightVariable = CGFloat(objWeeklyOnGoingChallengeModel.body?.height(constraintedWidth: cell.lblChallengeDesc.frame.width , font: UIFont(name: "Typewriter_Condensed", size: 20)!) ?? 0.0)
       
        print("get height :", getBodyHeightVariable)
        return cell
        
    }
    
    
    func cellForRowAtIndexLastWinner(tableView:UITableView,indexPath:IndexPath,topView:UIViewController)->UITableViewCell{
   
    if indexPath.row == 0{
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LastWinnerCell
    cell.lblChalengeTitle.text = (objWeeklyLastWinnerChallengeModel.title ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        getTitleHeightVariable = CGFloat(objWeeklyLastWinnerChallengeModel.title?.height(constraintedWidth: cell.lblChalengeTitle.frame.width , font: UIFont(name: "Typewriter_Condensed", size: 20)!) ?? 30.0)
        print("getTitleHeightVariable",getTitleHeightVariable)
        print(cell.lblChalengeTitle.text)
    return cell
    }
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellDesc", for: indexPath) as! LastWinnerCell
        //cell.lblChallengeDisc.backgroundColor = .white
        cell.lblChallengeDisc.text = "By - \(objWeeklyLastWinnerChallengeModel.author.trimmingCharacters(in: .whitespaces))\n\n\(objWeeklyLastWinnerChallengeModel.body ?? "")"
       
        getBodyHeightVariable = CGFloat(objWeeklyLastWinnerChallengeModel.body?.height(constraintedWidth: cell.lblChallengeDisc.frame.width , font: UIFont(name: "Typewriter_Condensed", size: 19.5)!) ?? 0.0)
        cell.lblChallengeDisc.textColor = .black
    print("get height :", getBodyHeightVariable)
    return cell
    }
    
    func getHeightWeekly(indexPath:IndexPath)->CGFloat{
        if indexPath.row == 0{
            return getTitleHeightVariable + 45
        }else{
            return UITableViewAutomaticDimension
           // return 400
        }
    }
    
    
    func btnViewAd(btnViewAds:UIButton,topView:UIViewController){
//        if btnViewAds.titleLabel?.text == "Participate"{
//            composeVC = MFMailComposeViewController()
//            composeVC?.mailComposeDelegate = self
//            composeVC?.setToRecipients(["desiredEmail@gmail.com"])
//            composeVC?.setSubject("My message")
//
//            if MFMailComposeViewController.canSendMail(){
//                topView.present(composeVC ?? MFMailComposeViewController(), animated: true, completion: nil)
//            }else{
//                print("Failed")
//            }
//        }else{
            if appDel.rewardBasedVideo?.isReady == true{
                appDel.rewardBasedVideo?.present(fromRootViewController: topView)
            } else {
                appDel.loadRewardAds()
            }
//        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
        case .cancelled:
            print("Mail cancelled")
        case .saved:
            print("Mail saved")
        case .sent:
            print("Mail sent")
        case .failed:
            print("Mail sent failure: \(error?.localizedDescription ?? "")")
        default:
            break
        }
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true)
        
    }
    
}
