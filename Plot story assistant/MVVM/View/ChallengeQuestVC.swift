//
//  ChallengeQuestVC.swift
//  Plot story assistant
//
//  Created by webastral on 11/3/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit
import SQLite3

protocol reloadIntersititialBanner {
    func isPop(isTrue:Bool)
}

class ChallengeQuestVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate {

    @IBOutlet weak var lblNavigationTitle: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    var db: OpaquePointer?
    var objDelegate : reloadIntersititialBanner?
    
//    var saveDataArray = [questionModel]()
//    var saveBioQuestArray = [questBioModel]()
    var bioId : Int = 0
    var challengId : Int = 0
    var index : Int = 0
    var charcterIndexpath : Int = 0
    
    var objChallengeQuestViewModel = ChallengeQuestViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tblView.dataSource = self
        tblView.delegate = self
        
        tblView.estimatedRowHeight = 44
        tblView.rowHeight = UITableViewAutomaticDimension
       // arr = UtilityMgr.combineChallengeQuestArray[index]
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToHomeSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
       objChallengeQuestViewModel.startup(bioId: bioId)
        
        lblNavigationTitle.text = DataViewModel.shared().titleNavigtionName
        
        lblUserName.text = DataViewModel.shared().createCharacterArray[charcterIndexpath].username ?? ""
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        objDelegate?.isPop(isTrue: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        objChallengeQuestViewModel.insetIntoTbl(topView: self)
    }
    
    @IBAction func btnSideMenuAction(_ sender: Any) {
        sideMenu.revealToggle(animated: true)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        objChallengeQuestViewModel.textDidChange(textView: textView, tblView: tblView)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        objChallengeQuestViewModel.textDidBeginChange(textView: textView, tblView: tblView)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        objChallengeQuestViewModel.textDidEndEditing(textView: textView, tblView: tblView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objChallengeQuestViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChallengeQuestTVC
        cell.txtAnswer.delegate = self
        cell.txtAnswer.tag = indexPath.row
        cell.lblQuestion.text = objChallengeQuestViewModel.saveDataArray[indexPath.row].quest ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return UITableViewAutomaticDimension
    }
    

}
