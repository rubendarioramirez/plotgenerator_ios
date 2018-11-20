//
//  GuideDetailVC.swift
//  Plot story assistant
//
//  Created by webastral on 11/3/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GuideDetailVC: UIViewController,UITableViewDataSource,UITableViewDelegate,AdsBannerDelegate  {

    @IBOutlet weak var adBannerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var adsBannerView: GADBannerView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    var guideType = String()
    var headerName = String()
    
    var objGuideDetailViewModel = GuideDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         AdBannerView.shared().objDelegate = self
        AdBannerView.shared().adsView(adsBannerView: adsBannerView, topview: self)
       
        // Do any additional setup after loading the view.
        tblView.estimatedRowHeight = 44
        tblView.rowHeight = UITableViewAutomaticDimension
        
        tblView.dataSource = self
        tblView.delegate = self
        
        lblHeader.text = headerName
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToHomeSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)

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
        return objGuideDetailViewModel.numberOfSection(guideType: guideType)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      return objGuideDetailViewModel.cellForRowAtIndex(tableView: tableView, indexPath: indexPath, guideType: guideType)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

  
}
