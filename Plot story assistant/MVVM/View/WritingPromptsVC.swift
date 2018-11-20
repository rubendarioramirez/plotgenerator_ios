//
//  WritingPromptsVC.swift
//  Plot story assistant
//
//  Created by webastral on 11/2/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import GoogleMobileAds

class WritingPromptsVC: UIViewController,UITableViewDataSource,UITableViewDelegate,AdsBannerDelegate {
  
    @IBOutlet weak var adBannerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var adsBannerView: GADBannerView!
    
    var triggerArray = Array<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AdBannerView.shared().objDelegate = self
        
        AdBannerView.shared().adsView(adsBannerView: adsBannerView, topview: self)
        
        sideMenu = self.revealViewController()
        sideMenu.tapGestureRecognizer().isEnabled = true
        
    }
    
    func isloaded(isTrue: Bool) {
        if isTrue{
            adBannerBottomConstraint.constant = 0
        }
        else{
            adBannerBottomConstraint.constant = -55
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnSideMenuAction(_ sender: Any) {
        sideMenu.revealToggle(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UtilityMgr.WritingPromptArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WritingTVC
        cell.lblWritingPromt.text = UtilityMgr.WritingPromptArray[indexPath.row]
        if indexPath.row % 5 == 0{
            cell.backgroundColor = UtilityMgr.writingPromptBackgroundColor[0]
        }
        else if indexPath.row % 5 == 1{
             cell.backgroundColor = UtilityMgr.writingPromptBackgroundColor[1]
        }
        else if indexPath.row % 5 == 2{
            cell.backgroundColor = UtilityMgr.writingPromptBackgroundColor[2]
        }
        else if indexPath.row % 5 == 3{
            cell.backgroundColor = UtilityMgr.writingPromptBackgroundColor[3]
        }
        else if indexPath.row % 5 == 4{
            cell.backgroundColor = UtilityMgr.writingPromptBackgroundColor[4]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

}
