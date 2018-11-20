//
//  AddProjectViewModel.swift
//  Plot story assistant
//
//  Created by webastral on 11/19/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit

class AddProjectViewModel: NSObject {

    
    func startup(isEdit:Bool,projectId:Int,tfProjectName:UITextField,tfGenre:UITextField,tvPlotSummary:UITextView){
        if isEdit == true{
            DataViewModel.shared().showquery(projectid: projectId, completion: { (status) in
                if status{
                    tfProjectName.text = DataViewModel.shared().projectListArray.first?.projectName ?? ""
                    tfGenre.text = DataViewModel.shared().projectListArray.first?.genre ?? ""
                    tvPlotSummary.text = DataViewModel.shared().projectListArray.first?.plotSummary ?? ""
                }
            })
        }
    }
    
    func saveData(tfProjectName:UITextField,tfGenre:UITextField,tvPlotSummary:UITextView,isEdit:Bool,projectId:Int,topView:UIViewController){
        if tfProjectName.text == ""{
            UtilityMgr.displayAlert(title: "", message: "Really no name for your project? Try again with something more creative", control: ["OK"])
        }
        else{
            if isEdit == true{
                DataViewModel.shared().addProjectUpdateQuery(tfProjectName: tfProjectName, tfGenre: tfGenre, tvPlotSummary: tvPlotSummary, projectId: projectId, completion: { (status) in
                    if status{
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
            }else{
                DataViewModel.shared().insert(tfProjectName: tfProjectName, tfGenre: tfGenre, tvPlotSummary: tvPlotSummary) { (status) in
                    if status{
                        topView.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    
    func deleteData(isEdit:Bool,projectId:Int,topView:UIViewController){
        if isEdit == true{
            DataViewModel.shared().addProjectDeleteQuery(projectId: projectId) { (status) in
                if status{
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
        }else{
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
