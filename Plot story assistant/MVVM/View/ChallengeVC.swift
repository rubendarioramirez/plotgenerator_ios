//
//  ChallengeVC.swift
//  Plot story assistant
//
//  Created by webastral on 11/3/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit
import GoogleMobileAds




class ChallengeVC: UIViewController,UITableViewDataSource,UITableViewDelegate,AdsBannerDelegate,interstitialBannerDelegate,reloadIntersititialBanner  {
    
    @IBOutlet weak var adBannerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var adsBannerView: GADBannerView!
    
    var bioId : Int = 0
    var projectId : Int = 0
    var charcterIndexpath : Int = 0
    
    var gameTimer: Timer!
    
    var objChallengeViewModel = ChallengeViewModel()
    
    var obj = ChallengeQuestVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AdBannerView.shared().objInterstitialDelegate = self
        
         AdBannerView.shared().objDelegate = self
         AdBannerView.shared().adsView(adsBannerView: adsBannerView, topview: self)
    
        // Do any additional setup after loading the view.
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToHomeSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
         gameTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(showAds), userInfo: nil, repeats: true)
        
    }
    
    func isPop(isTrue: Bool) {
        gameTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(showAds), userInfo: nil, repeats: true)
    }
    
    @objc func showAds(){
        objChallengeViewModel.interstitialShow(interstitial: AdBannerView.shared().interstitial, topView: self)
    }
    
    
    func isDismiss(isTrue: Bool) {
        gameTimer.invalidate()
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
        return UtilityMgr.challengeTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       return objChallengeViewModel.cellForRowAtIndex(tableView:tableView,indexPath:indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 432
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       objChallengeViewModel.didSelectAtRow(indexPath: indexPath, bioId: bioId, charcterIndexpath: charcterIndexpath, projectId: projectId, topView: self)
    }
    
}
