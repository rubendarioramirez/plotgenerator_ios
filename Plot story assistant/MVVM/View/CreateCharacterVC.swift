//
//  CreateCharacterVC.swift
//  Plot story assistant
//
//  Created by webastral on 11/6/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class CreateCharacterVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate {

    @IBOutlet weak var lblHeaderCharacter: UILabel!
    @IBOutlet weak var viewNoteBottom: UIView!
    @IBOutlet weak var viewDesiredBottom: UIView!
    @IBOutlet weak var viewDesired2Bottom: UIView!
    @IBOutlet weak var viewDefMomentBottom: UIView!
    @IBOutlet weak var viewTrait3Bottom: UIView!
    @IBOutlet weak var viewTrait2Bottom: UIView!
    @IBOutlet weak var viewTrait1Bottom: UIView!
    @IBOutlet weak var viewCatchBottom: UIView!
    @IBOutlet weak var viewPOBBottom: UIView!
    @IBOutlet weak var viewProfessionBottom: UIView!
    @IBOutlet weak var viewAgeBottom: UIView!
    @IBOutlet weak var viewNameBottom: UIView!
    @IBOutlet weak var btnDelete: UIButton!
    
    @IBOutlet weak var tvNotes: IQTextView!
    @IBOutlet weak var tvDesired2: IQTextView!
    @IBOutlet weak var tvDesired: IQTextView!
    @IBOutlet weak var tvChildhodMoment: IQTextView!
    
    @IBOutlet weak var lblGuideType: UILabel!
    
    @IBOutlet weak var tfTrait3: UITextField!
    @IBOutlet weak var tfTrait2: UITextField!
    @IBOutlet weak var tfTrait1: UITextField!
    
    @IBOutlet weak var tvCatachPhrase: IQTextView!
    
    @IBOutlet weak var tfPOB: UITextField!
    @IBOutlet weak var tfProfession: UITextField!
    
    @IBOutlet weak var lblGender: UILabel!
    
    @IBOutlet weak var tfAGe: UITextField!
    @IBOutlet weak var tfName: UITextField!
    
    @IBOutlet weak var lblProjectName: UILabel!
    @IBOutlet weak var GuideTypesTblView: UITableView!
    @IBOutlet weak var genderTblView: UITableView!
    
    var isGender : Bool = false
    var isGuide :Bool = false
    var projectId : Int = 0
    var isEditRandomCharacter : Bool = false
    var createCharacterId : Int = 0
    var bioId : Int = 0
    var indexpath : Int = 0
    var projectHeaderName : String = ""
    
    var objCreateCharacterViewModel = CreateCharacterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        delegateSelf(textfield: tfTrait3, textview: tvNotes)
        delegateSelf(textfield: tfTrait2, textview: tvDesired2)
        delegateSelf(textfield: tfTrait1, textview: tvDesired)
        delegateSelf(textfield: tfPOB, textview: tvChildhodMoment)
        delegateSelf(textfield: tfProfession, textview: tvCatachPhrase)
        delegateSelf(textfield: tfAGe, textview: nil)
        delegateSelf(textfield: tfName, textview: nil)
        
        
        tbldataSourceDelegate(tbl: GuideTypesTblView)
        tbldataSourceDelegate(tbl: genderTblView)
        GuideTypesTblView.isHidden = true
        genderTblView.isHidden = true
        lblProjectName.isHidden = false
        btnDelete.isHidden = true
        
        lblProjectName.text = projectHeaderName
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToHomeSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        lblHeaderCharacter.text = "Create Character"
        
        objCreateCharacterViewModel.isExist(isEditRandomCharacter: isEditRandomCharacter, lblHeaderCharacter: lblHeaderCharacter, lblProjectName: lblProjectName, btnDelete: btnDelete, bioId: bioId, tfName: tfName, tfAGe: tfAGe, lblGender: lblGender, tfProfession: tfProfession, tfPOB: tfPOB, tvCatachPhrase: tvCatachPhrase, tfTrait1: tfTrait1, tfTrait2: tfTrait2, tfTrait3: tfTrait3, lblGuideType: lblGuideType, tvChildhodMoment: tvChildhodMoment, tvDesired: tvDesired, tvDesired2: tvDesired, tvNotes: tvNotes)
        
    }
    
    func delegateSelf(textfield:UITextField? = nil,textview:IQTextView? = nil){
        textfield?.delegate = self
        textview?.delegate = self
    }
    
    
    @IBAction func btnSideMenuAction(_ sender: Any) {
        sideMenu.revealToggle(animated: true)
    }
    
    @IBAction func btnDeleteAction(_ sender: Any) {
        objCreateCharacterViewModel.deleteData(bioId: bioId, topView: self)
  }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        objCreateCharacterViewModel.selectedOrUnSelectedTextField(viewNameBottom: viewNameBottom, viewAgeBottom: viewAgeBottom, viewPOBBottom: viewPOBBottom, viewTrait1Bottom: viewTrait1Bottom, viewTrait2Bottom: viewTrait2Bottom, viewTrait3Bottom: viewTrait3Bottom, viewProfessionBottom: viewProfessionBottom, textField: textField, selectedTextBottomColor: Color.selectedTextBottomColor, topView: self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        objCreateCharacterViewModel.selectedOrUnSelectedTextField(viewNameBottom: viewNameBottom, viewAgeBottom: viewAgeBottom, viewPOBBottom: viewPOBBottom, viewTrait1Bottom: viewTrait1Bottom, viewTrait2Bottom: viewTrait2Bottom, viewTrait3Bottom: viewTrait3Bottom, viewProfessionBottom: viewProfessionBottom, textField: textField, selectedTextBottomColor: Color.unSelectedTextBottomColor, topView: self)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        objCreateCharacterViewModel.selectedOrUnselectedTextView(viewNoteBottom: viewNoteBottom, viewDesiredBottom: viewDesiredBottom, viewDesired2Bottom: viewDesired2Bottom, viewCatchBottom: viewCatchBottom, viewDefMomentBottom: viewDefMomentBottom, textView: textView, selectedTextBottomColor: Color.selectedTextBottomColor, topView: self)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
      objCreateCharacterViewModel.selectedOrUnselectedTextView(viewNoteBottom: viewNoteBottom, viewDesiredBottom: viewDesiredBottom, viewDesired2Bottom: viewDesired2Bottom, viewCatchBottom: viewCatchBottom, viewDefMomentBottom: viewDefMomentBottom, textView: textView, selectedTextBottomColor: Color.unSelectedTextBottomColor, topView: self)
    }
    
    func tbldataSourceDelegate(tbl:UITableView){
        tbl.dataSource = self
        tbl.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnGenderTblAction(_ sender: Any) {
       objCreateCharacterViewModel.genderTbl(genderTblView: genderTblView)
    }
    
    @IBAction func btnGuideTypesAction(_ sender: Any) {
       objCreateCharacterViewModel.guideTypeTbl(GuideTypesTblView: GuideTypesTblView)
    }
    
    @IBAction func btnDiceAction(_ sender: Any) {
       objCreateCharacterViewModel.diceShuffle(lblGender: lblGender, tfName: tfName, tfAGe: tfAGe, tfProfession: tfProfession, tfPOB: tfPOB, tvCatachPhrase: tvCatachPhrase, tfTrait1: tfTrait1, tfTrait2: tfTrait2, tfTrait3: tfTrait3, lblGuideType: lblGuideType, tvChildhodMoment: tvChildhodMoment, tvDesired: tvDesired, tvDesired2: tvDesired2)
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        objCreateCharacterViewModel.saveData(isEditRandomCharacter: isEditRandomCharacter, tfName: tfName, tfAGe: tfAGe, lblGender: lblGender, tfProfession: tfProfession, tfPOB: tfPOB, tvCatachPhrase: tvCatachPhrase, tfTrait1: tfTrait1, tfTrait2: tfTrait2, tfTrait3: tfTrait3, lblGuideType: lblGuideType, tvChildhodMoment: tvChildhodMoment, tvDesired: tvDesired, tvDesired2: tvDesired2, tvNotes: tvNotes, projectId: projectId, bioId: bioId, topView: self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objCreateCharacterViewModel.numberOfSection(tableView: tableView, GuideTypesTblView: GuideTypesTblView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       return objCreateCharacterViewModel.cellForRowAtIndex(tableView: tableView, topView: self, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      objCreateCharacterViewModel.didSelectAtRow(tableView: tableView, topView: self, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
}
