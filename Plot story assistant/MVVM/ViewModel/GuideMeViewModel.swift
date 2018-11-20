//
//  GuideMeViewModel.swift
//  Plot story assistant
//
//  Created by webastral on 11/19/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit

class GuideMeViewModel: NSObject {

    
    func cellForRowAtIndex(tableView:UITableView,indexPath:IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HeroJourneyTVC
        cell.lblHeading.text = UtilityMgr.guideMeHeadingArray[indexPath.row]
        cell.lblTitle.text = UtilityMgr.guideMeTitleArray[indexPath.row]
        cell.lblDetail.text = UtilityMgr.guideMeDetailArray[indexPath.row]
        return cell
    }
    
    
    func didSelectAtRow(indexPath:IndexPath,topView:UIViewController){
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "GuideDetailVC") as! GuideDetailVC
        vc.guideType = UtilityMgr.didSelctGuideTypeArray[indexPath.row]
        vc.headerName = UtilityMgr.guideMeTitleArray[indexPath.row]
        topView.navigationController?.pushViewController(vc, animated: true)
    }
    
}
