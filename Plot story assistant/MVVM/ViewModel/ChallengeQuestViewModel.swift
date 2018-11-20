//
//  ChallengeQuestViewModel.swift
//  Plot story assistant
//
//  Created by webastral on 11/19/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit


class ChallengeQuestViewModel: NSObject {

    var saveDataArray = [questionModel]()
    var saveBioQuestArray = [questBioModel]()
    var challengId : Int = 0
    
    
    func startup(bioId:Int){
        saveDataArray.removeAll()
        let decoder = JSONDecoder()
        if let questionData = UserDefaults.standard.data(forKey: "questDict\(bioId)"),
            let data = try? decoder.decode([questionModel].self, from: questionData) {
            saveDataArray = data
        }
        
        if let questionData = UserDefaults.standard.data(forKey: "questBioDict\(bioId)"),
            let data = try? decoder.decode([questBioModel].self, from: questionData) {
            saveBioQuestArray = data
        }
        
        DataViewModel.shared().questAlreadyExist(chalngId: saveDataArray.first?.challengeId ?? 0 ,bioId:bioId)
    }
    
    
    func numberOfRowsInSection()->Int{
        return saveDataArray.count
    }
    
    
    func insetIntoTbl(topView:UIViewController){
        let challenId = saveDataArray.first?.challengeId ?? 0
        DataViewModel.shared().insert(saveDataArray: saveBioQuestArray, challengId: challenId) { (success) in
            if let controllers = topView.navigationController?.viewControllers{
                
                for vc in controllers{
                    
                    if(vc.isKind(of: CharacterBiographyVC.self)){
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
    
    
    func textDidChange(textView:UITextView,tblView:UITableView){
        let startHeight = textView.frame.size.height
        let calcHeight = textView.sizeThatFits(textView.frame.size).height  //iOS 8+ only
        
        if startHeight != calcHeight {
            
            UIView.setAnimationsEnabled(false) // Disable animations
            tblView.beginUpdates()
            tblView.endUpdates()
            
            // Might need to insert additional stuff here if scrolls
            // table in an unexpected way.  This scrolls to the bottom
            // of the table. (Though you might need something more
            // complicated if editing in the middle.)
            
            tblView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            UIView.setAnimationsEnabled(true)
        }
    }
    
    func textDidBeginChange(textView:UITextView,tblView:UITableView){
        let index = IndexPath(row: textView.tag, section: 0)
        let cell = tblView.cellForRow(at: index) as! ChallengeQuestTVC
        cell.lblBottom.backgroundColor = Color.selectedTextBottomColor
    }
    
    
    func textDidEndEditing(textView:UITextView,tblView:UITableView){
        let index = IndexPath(row: textView.tag, section: 0)
        let cell = tblView.cellForRow(at: index) as! ChallengeQuestTVC
        cell.lblBottom.backgroundColor = Color.unSelectedTextBottomColor
        
       saveDataArray[textView.tag].answer = textView.text ?? ""
        saveBioQuestArray[textView.tag].answer = textView.text ?? ""
    }
    
}
