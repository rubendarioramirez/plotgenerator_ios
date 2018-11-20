//
//  HeroJourneyVC.swift
//  Plot story assistant
//
//  Created by webastral on 11/2/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HeroJourneyVC: UIViewController,UITableViewDataSource,UITableViewDelegate,AdsBannerDelegate  {
    
    @IBOutlet weak var adBannerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var adsBannerView: GADBannerView!
    
    var objHeroJourneyViewModel = HeroJourneyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

         AdBannerView.shared().objDelegate = self
        
         AdBannerView.shared().adsView(adsBannerView: adsBannerView, topview: self)
        
        // Do any additional setup after loading the view.
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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return UtilityMgr.heroJouneryHeadingArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objHeroJourneyViewModel.numberOfSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return objHeroJourneyViewModel.cellForRowAtIndex(tableView:tableView,indexPath:indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 432
    }

}
