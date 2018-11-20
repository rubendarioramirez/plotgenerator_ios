//
//  ChallengeViewModel.swift
//  Plot story assistant
//
//  Created by webastral on 11/19/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ChallengeViewModel: NSObject {
  
    var questSavedata = [questionModel]()
    var bioQuestArray = [questBioModel]()
    
    
    func interstitialShow(interstitial:GADInterstitial,topView:UIViewController){
        if interstitial.isReady {
            interstitial.present(fromRootViewController: topView)
        } else {
            print("Ad wasn't ready")
        }
    }
    
    
    func cellForRowAtIndex(tableView:UITableView,indexPath:IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HeroJourneyTVC
        cell.lblHeading.text = UtilityMgr.challengeDescArray[indexPath.row]
        cell.lblTitle.text = UtilityMgr.challengeTitleArray[indexPath.row]
        cell.lblDetail.text = UtilityMgr.challengeDescLongArray[indexPath.row]
        return cell
    }
    
    func didSelectAtRow(indexPath:IndexPath,bioId:Int,charcterIndexpath:Int,projectId:Int,topView:ChallengeVC){
        if UtilityMgr.combineChallengeQuestArray.count != indexPath.row{
            questSavedata.removeAll()
            let story = UIStoryboard(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: "ChallengeQuestVC") as! ChallengeQuestVC
            vc.objDelegate = topView
            vc.index = indexPath.row
            vc.bioId = bioId
            vc.charcterIndexpath = charcterIndexpath
            
            for i in 0..<UtilityMgr.combineChallengeQuestArray[indexPath.row].count{
                let obj = questionModel()
                let data = ["quest":UtilityMgr.combineChallengeQuestArray[indexPath.row][i],"bioId":bioId,"projId":projectId,"answer":"","questId":i,"challengeId":indexPath.row + 1] as [String : Any]
                print(data)
                obj.set(dict: data)
                questSavedata.append(obj)
            }
            
            for (_,value) in (UtilityMgr.challengeQuestionsArray[UtilityMgr.challengBioTitleArray[indexPath.row]]?.enumerated())!{
                let obj = questBioModel()
                let data = ["quest":value,"bioId":bioId,"projId":projectId,"answer":"","questId":1,"challengeId":indexPath.row + 1] as [String : Any]
                
                print(data)
                obj.set(dict: data)
                bioQuestArray.append(obj)
            }
            saveData(bioId:bioId)
            topView.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func saveData(bioId:Int){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(questSavedata) {
            UserDefaults.standard.set(encoded, forKey: "questDict\(bioId)")
        }
        let encoder1 = JSONEncoder()
        if let encoded = try? encoder1.encode(bioQuestArray) {
            UserDefaults.standard.set(encoded, forKey: "questBioDict\(bioId)")
        }
    }

}
