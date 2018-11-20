//
//  ViewController.swift
//  Plot story assistant
//
//  Created by webastral on 11/1/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit
import SQLite3
import GoogleMobileAds

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,AdsBannerDelegate {
    
    
    @IBOutlet weak var adBannerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblEmpty: UILabel!
    @IBOutlet weak var adsBannerView: GADBannerView!
    @IBOutlet weak var tblView: UITableView!
    var db: OpaquePointer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      AdBannerView.shared().objDelegate = self
        
       AdBannerView.shared().interstitial = AdBannerView.shared().createAndLoadInterstitial()
        
       AdBannerView.shared().adsView(adsBannerView: adsBannerView, topview: self)

        // Do any additional setup after loading the view, typically from a nib.
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataViewModel.shared().createDatabase(tbl: tblView)
     // let aram =  UtilityMgr.femaleNameArray[UtilityMgr.femaleNameArray.random()]
       
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
          self.view.layoutIfNeeded()
    }
    
    @IBAction func btnSideMenuAction(_ sender: Any) {
        sideMenu.revealToggle(animated: true)
    }
    
    @IBAction func btnAddProjectAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddProjectVC") as! AddProjectVC
         vc.isEdit = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  DataViewModel.shared().projectListArray.count != 0{
            lblEmpty.isHidden = true
            return DataViewModel.shared().projectListArray.count
        }else{
            lblEmpty.isHidden = false
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WritingTVC
        cell.lblProjectName.text = DataViewModel.shared().projectListArray[indexPath.row].projectName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CharactersVC") as! CharactersVC
        vc.projectId = DataViewModel.shared().projectListArray[indexPath.row].projectId ?? 0
        vc.projectHeaderName = DataViewModel.shared().projectListArray[indexPath.row].projectName ?? ""
        
        DataViewModel.shared().titleProject(index: indexPath.row)
      //  AddProjectViewModel.shared().query123()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}

