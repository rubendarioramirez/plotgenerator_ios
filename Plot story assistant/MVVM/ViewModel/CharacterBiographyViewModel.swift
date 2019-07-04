//
//  CharacterBiographyViewModel.swift
//  Plot story assistant
//
//  Created by webastral on 11/19/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CharacterBiographyViewModel: NSObject {

    var feMaleBiography : String = ""
    var bioGraphyString : String = ""
    var maleBiography : String = ""
    
    func interstitialShow(interstitial:GADInterstitial,topView:UIViewController){
        if interstitial.isReady {
            interstitial.present(fromRootViewController: topView)
        } else {
            print("Ad wasn't ready")
        }
    }
    
    func numberOfSection(section:Int)->Int{
        switch (section) {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 1
        default:
            print("out of boundary")
            return 0
        }
    }
    
    func cellForRowAtIndex(tableView:UITableView,indexPath:IndexPath,topView:CharacterBiographyVC)->UITableViewCell{
        switch (indexPath.section) {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CharacterBiographyTVC
            cell.lblBio.text = checkGender(isGender: topView.isGender, index: topView.indexpath)
            if topView.shareString.contains(checkGender(isGender: topView.isGender, index: topView.indexpath)){
            }else{
                topView.shareString = "\(checkGender(isGender: topView.isGender, index: topView.indexpath))\nChallenges\n"
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellTitle", for: indexPath) as! CharacterBiographyTVC
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellChallenge", for: indexPath) as! CharacterBiographyTVC
            
            var str = ""
            if DataViewModel.shared().questDataArray.count != 0{
                if DataViewModel.shared().questDataArray[indexPath.row].bioId == topView.bioId{
                    
                    let combination = NSMutableAttributedString()
                    
                    let fontBold = UIFont(name: "Typewriter_Condensed-Bold", size: 18)!
                    
                    let fontRegular = UIFont(name: "Typewriter_Condensed", size: 18)!
                    
                    let attrs = [NSAttributedStringKey.font : fontBold]
                    let attrsRegular = [NSAttributedStringKey.font : fontRegular]
                    
                    for i in 0..<DataViewModel.shared().questDataArray.count{
                        let indexStr = DataViewModel.shared().questDataArray[i].challengeId ?? 1
                        if str.contains(UtilityMgr.challengeBioArray[indexStr - 1]){
                            
                            let regularAnswerString = NSMutableAttributedString(string: "\(DataViewModel.shared().questDataArray[i].Asnwer ?? "")\n", attributes:attrsRegular)
                            
                            
                            let boldQuestionString = NSMutableAttributedString(string: "\n\(DataViewModel.shared().questDataArray[i].Question ?? "")", attributes:attrs)
                            
                            combination.append(boldQuestionString)
                            combination.append(regularAnswerString)
                            
                            
                            str.append("\(DataViewModel.shared().questDataArray[i].Question ?? "")\n\(DataViewModel.shared().questDataArray[i].Asnwer ?? "")\n")
                        }else{
                            
                            _ = NSMutableAttributedString(string:"\n\(UtilityMgr.challengeBioArray[indexStr - 1])")
                            
                            
                            let boldString = NSMutableAttributedString(string: "\(UtilityMgr.challengeBioArray[indexStr - 1])", attributes:attrs)
                            
                            let regularAnswerString = NSMutableAttributedString(string: "\(DataViewModel.shared().questDataArray[i].Asnwer ?? "")\n", attributes:attrsRegular)
                            
                            let boldQuestionString = NSMutableAttributedString(string: "\n\(DataViewModel.shared().questDataArray[i].Question ?? "")", attributes:attrs)
                            
                            combination.append(boldString)
                            combination.append(boldQuestionString)
                            combination.append(regularAnswerString)
                            
                            str.append("\n\(UtilityMgr.challengeBioArray[indexStr - 1])\n\(DataViewModel.shared().questDataArray[i].Question ?? "")\n\(DataViewModel.shared().questDataArray[i].Asnwer ?? "")\n")
                        }
                    }
                    
                    // cell.lblAnswer.text = "\(str)"
                    cell.lblAnswer.attributedText = combination
                    
                    if topView.shareString.contains(str){
                    }else{
                        topView.shareString.append(str)
                    }
                }
            }
            
            return cell
        default:
            print("out of boundary")
            return UITableViewCell()
        }
    }
    
    func checkGender(isGender:String,index:Int)->String{
        bioData(index: index)
        if isGender == "Male"{
            return "\(bioGraphyString)\(maleBiography)"
        }else{
            return "\(bioGraphyString)\(feMaleBiography)"
        }
    }
    
    func bioData(index:Int){
        bioGraphyString = "\n\(DataViewModel.shared().createCharacterArray[index].username ?? "") is\n\(DataViewModel.shared().createCharacterArray[index].age ?? "") years old.\nBorn in\n\(DataViewModel.shared().createCharacterArray[index].placeofbirth ?? "")\nWorks as \(DataViewModel.shared().createCharacterArray[index].profession ?? "")\n"
        
        maleBiography = "In his mind he wants \(DataViewModel.shared().createCharacterArray[index].desire ?? "")\nBut is that what he really wants? Or he actually needs \(DataViewModel.shared().createCharacterArray[index].desire1 ?? "")\nAbout his childhood we know that he \(DataViewModel.shared().createCharacterArray[index].defmoment ?? "")\nAlso his friends says that he is \(DataViewModel.shared().createCharacterArray[index].trait ?? ""), \(DataViewModel.shared().createCharacterArray[index].trait1 ?? ""), \(DataViewModel.shared().createCharacterArray[index].trait2 ?? "")\n\nA phrase that people will commonly associate with him is \(DataViewModel.shared().createCharacterArray[index].catchphrase ?? "")\n\nNotes\n\(DataViewModel.shared().createCharacterArray[index].notes ?? "")\n"
        
        feMaleBiography = "In her mind she wants \(DataViewModel.shared().createCharacterArray[index].desire ?? "")\nBut is that what she really wants? Or she actually needs \(DataViewModel.shared().createCharacterArray[index].desire1 ?? "")\nAbout her childhood we know that she \(DataViewModel.shared().createCharacterArray[index].defmoment ?? "")\nAlso her friends says that she is \(DataViewModel.shared().createCharacterArray[index].trait ?? ""), \(DataViewModel.shared().createCharacterArray[index].trait1 ?? ""), \(DataViewModel.shared().createCharacterArray[index].trait2 ?? "")\n\nA phrase that people will commonly associate with her is \(DataViewModel.shared().createCharacterArray[index].catchphrase ?? "")\n\nNotes\n\(DataViewModel.shared().createCharacterArray[index].notes ?? "")\n"
    
    }
    
}
