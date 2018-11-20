//
//  CreateCharacterViewModel.swift
//  Plot story assistant
//
//  Created by webastral on 11/19/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class CreateCharacterViewModel: NSObject {

    
    func diceShuffle(lblGender:UILabel,tfName:UITextField,tfAGe:UITextField,tfProfession:UITextField,tfPOB:UITextField,tvCatachPhrase:IQTextView,tfTrait1:UITextField,tfTrait2:UITextField,tfTrait3:UITextField,lblGuideType:UILabel,tvChildhodMoment:IQTextView,tvDesired:IQTextView,tvDesired2:IQTextView){
        let genderRandom = UtilityMgr.genderArray[UtilityMgr.genderArray.random()]
        lblGender.text = genderRandom
        var firstName = String()
        if genderRandom == "Male"{
            firstName = UtilityMgr.maleNameArry[UtilityMgr.maleNameArry.random()]
        }
        else{
            firstName = UtilityMgr.femaleNameArray[UtilityMgr.femaleNameArray.random()]
        }
        
        tfName.text = "\(firstName) \(UtilityMgr.lastNameArray[UtilityMgr.lastNameArray.random()])"
        
        tfAGe.text = "\(UtilityMgr.randomNumber(MIN: 12, MAX: 80))"
        
        tfProfession.text = UtilityMgr.professionArray[UtilityMgr.professionArray.random()]
        
        tfPOB.text = UtilityMgr.placebirthArray[UtilityMgr.placebirthArray.random()]
        
        tvCatachPhrase.text = UtilityMgr.phrasesArray[UtilityMgr.phrasesArray.random()]
        
        tfTrait1.text = UtilityMgr.traitArray[UtilityMgr.traitArray.random()]
        
        tfTrait2.text = UtilityMgr.traitArray[UtilityMgr.traitArray.random()]
        
        tfTrait3.text = UtilityMgr.traitArray[UtilityMgr.traitArray.random()]
        
        lblGuideType.text = UtilityMgr.charGuideTypesTitlesArray["char_guide_types_titles"]?[(UtilityMgr.charGuideTypesTitlesArray["char_guide_types_titles"]?.random()) ?? 0]
        
        tvChildhodMoment.text = UtilityMgr.defmomentArray[UtilityMgr.defmomentArray.random()]
        
        tvDesired.text = UtilityMgr.desireArray[UtilityMgr.desireArray.random()]
        
        tvDesired2.text = UtilityMgr.desireArray1[UtilityMgr.desireArray1.random()]
    }
    
    
    func saveData(isEditRandomCharacter:Bool,tfName:UITextField,tfAGe:UITextField,lblGender:UILabel,tfProfession:UITextField,tfPOB:UITextField,tvCatachPhrase:IQTextView,tfTrait1:UITextField,tfTrait2:UITextField,tfTrait3:UITextField,lblGuideType:UILabel,tvChildhodMoment:IQTextView,tvDesired:IQTextView,tvDesired2:IQTextView,tvNotes:IQTextView,projectId:Int,bioId:Int,topView:UIViewController){
        if isEditRandomCharacter == true{
            DataViewModel.shared().createCharacterUpdateQuery(tfName: tfName, tfAge: tfAGe, lblGender: lblGender, tfprofession: tfProfession, tfPOB: tfPOB, tvCatchPhrase: tvCatachPhrase, tfTrait: tfTrait1, tfTrait1: tfTrait2, tfTrait2: tfTrait3, lblGuideType: lblGuideType, tfchildhood: tvChildhodMoment, tvDesired: tvDesired, tvDesired1: tvDesired2, tvNotes: tvNotes, projectId: projectId, ID: bioId, completion: { (success) in
                if success {
                    if let controllers = topView.navigationController?.viewControllers{
                        
                        for vc in controllers{
                            
                            if(vc.isKind(of: ViewController.self)){
                                // isFlag = true
                                NotificationCenter.default.post(name: Notification.Name("isPop"), object: nil)
                                topView.navigationController?.popToViewController(vc, animated: true)
                                break
                            }
                            else{
                                // isFlag = false
                            }
                        }
                    }
                }
            })
        }
        else{
            DataViewModel.shared().insertCreateCharacter(tfName: tfName, tfAge: tfAGe, lblGender: lblGender, tfprofession: tfProfession, tfPOB: tfPOB, tvCatchPhrase: tvCatachPhrase, tfTrait: tfTrait1, tfTrait1: tfTrait2, tfTrait2: tfTrait3, lblGuideType: lblGuideType, tfchildhood: tvChildhodMoment, tvDesired: tvDesired, tvDesired1: tvDesired2, tvNotes: tvNotes, projectId: projectId) { (status) in
                if status == true{
                    if let controllers = topView.navigationController?.viewControllers{
                        
                        for vc in controllers{
                            
                            if(vc.isKind(of: ViewController.self)){
                                // isFlag = true
                                NotificationCenter.default.post(name: Notification.Name("isPop"), object: nil)
                                topView.navigationController?.popToViewController(vc, animated: true)
                                break
                            }
                            else{
                                // isFlag = false
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    func isExist(isEditRandomCharacter:Bool,lblHeaderCharacter:UILabel,lblProjectName:UILabel,btnDelete:UIButton,bioId:Int,tfName:UITextField,tfAGe:UITextField,lblGender:UILabel,tfProfession:UITextField,tfPOB:UITextField,tvCatachPhrase:IQTextView,tfTrait1:UITextField,tfTrait2:UITextField,tfTrait3:UITextField,lblGuideType:UILabel,tvChildhodMoment:IQTextView,tvDesired:IQTextView,tvDesired2:IQTextView,tvNotes:IQTextView){
        if isEditRandomCharacter == true{
            lblHeaderCharacter.text = "Edit Character"
            
            lblProjectName.isHidden = true
            btnDelete.isHidden = false
            
            DataViewModel.shared().ShowqueryCreateCharacter(createCharacterId: bioId, completion: { (status) in
                if status{
                    tfName.text = DataViewModel.shared().createCharacterArray.first?.username
                    tfAGe.text = DataViewModel.shared().createCharacterArray.first?.age
                    lblGender.text = DataViewModel.shared().createCharacterArray.first?.gender
                    tfProfession.text = DataViewModel.shared().createCharacterArray.first?.profession
                    tfPOB.text = DataViewModel.shared().createCharacterArray.first?.placeofbirth
                   tvCatachPhrase.text = DataViewModel.shared().createCharacterArray.first?.catchphrase
                   tfTrait1.text = DataViewModel.shared().createCharacterArray.first?.trait
                   tfTrait2.text = DataViewModel.shared().createCharacterArray.first?.trait1
                   tfTrait3.text = DataViewModel.shared().createCharacterArray.first?.trait2
                   lblGuideType.text = DataViewModel.shared().createCharacterArray.first?.guideType
                   tvChildhodMoment.text = DataViewModel.shared().createCharacterArray.first?.defmoment
                   tvDesired.text = DataViewModel.shared().createCharacterArray.first?.desire
                   tvDesired2.text = DataViewModel.shared().createCharacterArray.first?.desire1
                   tvNotes.text = DataViewModel.shared().createCharacterArray.first?.notes
                }
            })
        }
    }
    
    
    func deleteData(bioId:Int,topView:UIViewController){
        UtilityMgr.displayAlertWithCompletion(title: "", message: "Are you sure you want to delete this character?", control: ["Yes","No"]) { (option) in
            if option == "Yes"{
                DataViewModel.shared().createCharacterDeleteQuery(createCharacterId: bioId) { (success) in
                    if success{
                        
                        if let controllers = topView.navigationController?.viewControllers{
                            
                            for vc in controllers{
                                
                                if(vc.isKind(of: ViewController.self)){
                                    // isFlag = true
                                    NotificationCenter.default.post(name: Notification.Name("isPop"), object: nil)
                                    topView.navigationController?.popToViewController(vc, animated: true)
                                    break
                                }
                                else{
                                    // isFlag = false
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func numberOfSection(tableView:UITableView,GuideTypesTblView:UITableView)->Int{
        if tableView == GuideTypesTblView{
            return (UtilityMgr.charGuideTypesTitlesArray["char_guide_types_titles"]?.count) ?? 0
        }else{
            return UtilityMgr.genderSpinnerArray.count
        }
    }
    
    func cellForRowAtIndex(tableView:UITableView,topView:CreateCharacterVC,indexPath:IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CreateCharacterTVC
        if tableView == topView.GuideTypesTblView{
            cell.lblGuideType.text = UtilityMgr.charGuideTypesTitlesArray["char_guide_types_titles"]?[indexPath.row]
        }else{
            cell.lblGender.text = UtilityMgr.genderSpinnerArray[indexPath.row]
        }
        return cell
    }
    
    func didSelectAtRow(tableView:UITableView,topView:CreateCharacterVC,indexPath:IndexPath){
        if tableView == topView.GuideTypesTblView{
            topView.lblGuideType.text = UtilityMgr.charGuideTypesTitlesArray["char_guide_types_titles"]?[indexPath.row]
        }else{
            topView.lblGender.text = UtilityMgr.genderSpinnerArray[indexPath.row]
        }
    }
    
    func genderTbl(genderTblView:UITableView){
        if genderTblView.isHidden{
            genderTblView.isHidden = false
        }else{
            genderTblView.isHidden = true
        }
    }
    
    func guideTypeTbl(GuideTypesTblView:UITableView){
        if GuideTypesTblView.isHidden{
            GuideTypesTblView.isHidden = false
        }else{
            GuideTypesTblView.isHidden = true
        }
    }
    
    func selectedOrUnSelectedTextField(viewNameBottom:UIView,viewAgeBottom:UIView,viewPOBBottom:UIView,viewTrait1Bottom:UIView,viewTrait2Bottom:UIView,viewTrait3Bottom:UIView,viewProfessionBottom:UIView,textField:UITextField,selectedTextBottomColor:UIColor,topView:CreateCharacterVC){
        if textField == topView.tfName{
            viewNameBottom.backgroundColor = selectedTextBottomColor
        }else if textField == topView.tfAGe{
            viewAgeBottom.backgroundColor = selectedTextBottomColor
        }else if textField == topView.tfPOB{
            viewPOBBottom.backgroundColor = selectedTextBottomColor
        }else if textField == topView.tfTrait1{
            viewTrait1Bottom.backgroundColor = selectedTextBottomColor
        }else if textField == topView.tfTrait2{
            viewTrait2Bottom.backgroundColor = selectedTextBottomColor
        }else if textField == topView.tfTrait3{
            viewTrait3Bottom.backgroundColor = selectedTextBottomColor
        }else if textField == topView.tfProfession{
            viewProfessionBottom.backgroundColor = selectedTextBottomColor
        }
    }
    
    func selectedOrUnselectedTextView(viewNoteBottom:UIView,viewDesiredBottom:UIView,viewDesired2Bottom:UIView,viewCatchBottom:UIView,viewDefMomentBottom:UIView,textView:UITextView,selectedTextBottomColor:UIColor,topView:CreateCharacterVC){
        if textView == topView.tvNotes{
            viewNoteBottom.backgroundColor = selectedTextBottomColor
        }else if textView == topView.tvDesired{
            viewDesiredBottom.backgroundColor = selectedTextBottomColor
        }else if textView == topView.tvDesired2{
            viewDesired2Bottom.backgroundColor = selectedTextBottomColor
        }else if textView == topView.tvCatachPhrase{
            viewCatchBottom.backgroundColor = selectedTextBottomColor
        }else if textView == topView.tvChildhodMoment{
            viewDefMomentBottom.backgroundColor = selectedTextBottomColor
        }
    }
    
    
}
