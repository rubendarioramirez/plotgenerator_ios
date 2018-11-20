//
//  GuideDetailViewModel.swift
//  Plot story assistant
//
//  Created by webastral on 11/19/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit

class GuideDetailViewModel: NSObject {

    
    func numberOfSection(guideType:String)->Int{
        if (guideType == "char_guide_types_titles"){
            return (UtilityMgr.charGuideTypesTitlesArray["char_guide_types_titles"]?.count) ?? 0
        }
        else if (guideType == "lajos_text"){
            return (UtilityMgr.charGuideTypesDescArray["lajos_text"]?.count) ?? 0
        }
        else if (guideType == "change_arc_array_titles"){
            return (UtilityMgr.charGuideTypesTitlesArray["change_arc_array_titles"]?.count) ?? 0
        }
        else if (guideType == "antagonist_guide_array_titles"){
            return (UtilityMgr.charGuideTypesTitlesArray["antagonist_guide_array_titles"]?.count) ?? 0
        }
        return 0
    }
    
    
    func cellForRowAtIndex(tableView:UITableView,indexPath:IndexPath,guideType:String)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GuideDetailTVC
        
        if (guideType == "char_guide_types_titles"){
            cell.lblTitle.text = UtilityMgr.charGuideTypesTitlesArray["char_guide_types_titles"]?[indexPath.row]
            cell.lblGuideDesc.text = UtilityMgr.charGuideTypesDescArray["char_guide_types_titles"]?[indexPath.row]
        }
        else if (guideType == "lajos_text"){
            cell.lblTitleHeightConstraint.constant = 0
            cell.lblGuideDesc.text = UtilityMgr.charGuideTypesDescArray["lajos_text"]?[indexPath.row]
        }
        else if (guideType == "change_arc_array_titles"){
            cell.lblTitle.text = UtilityMgr.charGuideTypesTitlesArray["change_arc_array_titles"]?[indexPath.row]
            cell.lblGuideDesc.text = UtilityMgr.charGuideTypesDescArray["change_arc_array_titles"]?[indexPath.row]
        }
        else if (guideType == "antagonist_guide_array_titles"){
            cell.lblTitle.text = UtilityMgr.charGuideTypesTitlesArray["antagonist_guide_array_titles"]?[indexPath.row]
            cell.lblGuideDesc.text = UtilityMgr.charGuideTypesDescArray["antagonist_guide_array_titles"]?[indexPath.row]
        }
        return cell
    }
    
}
