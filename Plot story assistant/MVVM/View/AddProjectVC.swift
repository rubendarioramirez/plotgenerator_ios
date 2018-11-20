//
//  AddProjectVC.swift
//  Plot story assistant
//
//  Created by webastral on 11/5/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit

class AddProjectVC: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UITextViewDelegate {

    @IBOutlet weak var lblPlotBottom: UILabel!
    @IBOutlet weak var lblProjectBottom: UILabel!
    @IBOutlet weak var tvPlotSummary: UITextView!
    @IBOutlet weak var tfGenre: TextFieldCustom!
    @IBOutlet weak var tfProjectName: UITextField!
    
    let pickerView = UIPickerView()
    var projectId = Int()
    var isEdit = Bool()
    
    var objAddProjectViewModel = AddProjectViewModel()
    
     let myPickerData = ["Male","Female","Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        tfProjectName.delegate = self
        tvPlotSummary.delegate = self
        
        tfGenre.inputView = pickerView
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToHomeSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        objAddProjectViewModel.startup(isEdit: isEdit, projectId: projectId, tfProjectName: tfProjectName, tfGenre: tfGenre, tvPlotSummary: tvPlotSummary)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lblProjectBottom.backgroundColor = Color.selectedTextBottomColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        lblProjectBottom.backgroundColor = Color.unSelectedTextBottomColor
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        lblPlotBottom.backgroundColor = Color.selectedTextBottomColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        lblPlotBottom.backgroundColor = Color.unSelectedTextBottomColor
    }
    
    @IBAction func btnSideMenuAction(_ sender: Any) {
        sideMenu.revealToggle(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return UtilityMgr.genresArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return UtilityMgr.genresArray[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tfGenre.text = UtilityMgr.genresArray[row]
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnSaveAction(_ sender: Any) {
        objAddProjectViewModel.saveData(tfProjectName: tfProjectName, tfGenre: tfGenre, tvPlotSummary: tvPlotSummary, isEdit: isEdit, projectId: projectId, topView: self)
        
    }
    
    @IBAction func btnDeleteAction(_ sender: Any) {
        objAddProjectViewModel.deleteData(isEdit: isEdit, projectId: projectId, topView: self)
    }
    
    
}
