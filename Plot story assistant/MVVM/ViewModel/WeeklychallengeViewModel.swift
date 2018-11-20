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

class WeeklychallengeViewModel: NSObject,MFMailComposeViewControllerDelegate  {
    
    var ref: DatabaseReference!
    var composeVC : MFMailComposeViewController?
    var weeklyChallenge = Array<String>()

    func weeklyChallenge(topView:UIViewController,tblView:UITableView){
        ref = Database.database().reference()
        topView.showactivityIndicator()
        ref.child("writing_challenge").observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            topView.hideactivityIndicator()
            if let data = snapshot.value as? [String] {
                //  self.triggerArray = data
                self.weeklyChallenge = data
                tblView.reloadData()
            }
        })
    }
    
    
    func cellForRowAtIndex(tableView:UITableView,indexPath:IndexPath)->UITableViewCell{
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeeklyChallengeTVC
            cell.lblChallengeTitle.text = weeklyChallenge[indexPath.row]
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDesc", for: indexPath) as! WeeklyChallengeTVC
        cell.lblChallengeDesc.text = weeklyChallenge[indexPath.row]
        
        return cell
    }
    
    
    func btnViewAd(btnViewAds:UIButton,topView:UIViewController){
        if btnViewAds.titleLabel?.text == "Participate"{
            composeVC = MFMailComposeViewController()
            composeVC?.mailComposeDelegate = self
            composeVC?.setToRecipients(["desiredEmail@gmail.com"])
            composeVC?.setSubject("My message")
            
            if MFMailComposeViewController.canSendMail(){
                topView.present(composeVC ?? MFMailComposeViewController(), animated: true, completion: nil)
            }else{
                print("Failed")
            }
        }else{
            if appDel.rewardBasedVideo?.isReady == true{
                appDel.rewardBasedVideo?.present(fromRootViewController: topView)
            } else {
                appDel.loadRewardAds()
            }
        }
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
