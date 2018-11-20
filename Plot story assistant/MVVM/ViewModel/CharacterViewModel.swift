//
//  CharacterViewModel.swift
//  Plot story assistant
//
//  Created by webastral on 11/19/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit

class CharacterViewModel: NSObject {

    
    func showCreateCharacter(tblView:UITableView,projectId:Int){
        DataViewModel.shared().queryCreateCharacter(projectId: projectId) { (status) in
            print(status)
            if status == true{
                tblView.reloadData()
            }
        }
    }
    
    func numberOfSection(lblEmpty:UILabel)->Int{
        if DataViewModel.shared().createCharacterArray.count != 0{
            lblEmpty.isHidden = true
            return DataViewModel.shared().createCharacterArray.count
        }else{
            lblEmpty.isHidden = false
            return 0
        }
    }
    
    func cellForRowAtIndex(tableView:UITableView,indexPath:IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CreateCharacterTVC
        cell.lblCharacter.text = "\(DataViewModel.shared().createCharacterArray[indexPath.row].username ?? "") - \(DataViewModel.shared().createCharacterArray[indexPath.row].guideType ?? "")"
        return cell
    }
    
    func didSelectRowAtIndex(topView:UIViewController,indexPath:IndexPath,projectId:Int){
        let vc = topView.storyboard?.instantiateViewController(withIdentifier: "CharacterBiographyVC") as! CharacterBiographyVC
        vc.bioId = DataViewModel.shared().createCharacterArray[indexPath.row].id ?? 0
        vc.projectId = projectId
        vc.isGender = DataViewModel.shared().createCharacterArray[indexPath.row].gender ?? ""
        vc.indexpath = indexPath.row
        // UtilityMgr.index = indexPath.row
        UtilityMgr.gender = DataViewModel.shared().createCharacterArray[indexPath.row].gender ?? ""
        topView.navigationController?.pushViewController(vc, animated: true)
    }
    
}
