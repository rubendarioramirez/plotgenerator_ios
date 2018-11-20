//
//  HeroJourneyViewModel.swift
//  Plot story assistant
//
//  Created by webastral on 11/19/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit

class HeroJourneyViewModel: NSObject {
    
    
    
    func numberOfSection(section:Int)->Int{
        switch (section) {
        case 0:
            return UtilityMgr.heroJourneyTitleArray.count
        case 1:
            return UtilityMgr.heroJourneyTitleArray1.count
        case 2:
            return UtilityMgr.heroJourneyTitleArray2.count
        default:
            print("out of boundary")
            return 0
        }
    }
    
    func cellForRowAtIndex(tableView:UITableView,indexPath:IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HeroJourneyTVC
        switch (indexPath.section) {
        case 0:
            cell.lblHeading.text = UtilityMgr.heroJouneryHeadingArray[indexPath.section]
            cell.lblTitle.text = UtilityMgr.heroJourneyTitleArray[indexPath.row]
            cell.lblDetail.text = UtilityMgr.heroJourneyDetailArray[indexPath.row]
        case 1:
            cell.lblHeading.text = UtilityMgr.heroJouneryHeadingArray[indexPath.section]
            cell.lblTitle.text = UtilityMgr.heroJourneyTitleArray1[indexPath.row]
            cell.lblDetail.text = UtilityMgr.heroJourneyDetailArray1[indexPath.row]
        case 2:
            cell.lblHeading.text = UtilityMgr.heroJouneryHeadingArray[indexPath.section]
            cell.lblTitle.text = UtilityMgr.heroJourneyTitleArray2[indexPath.row]
            cell.lblDetail.text = UtilityMgr.heroJourneyDetailArray2[indexPath.row]
        default:
            print("out of boundary")
        }
        return cell
    }
    

}
