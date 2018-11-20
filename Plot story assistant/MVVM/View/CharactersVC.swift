//
//  CharactersVC.swift
//  Plot story assistant
//
//  Created by webastral on 11/6/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CharactersVC: UIViewController,UITableViewDataSource,UITableViewDelegate,AdsBannerDelegate  {
    
    
    @IBOutlet weak var adBannerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var adsBannerView: GADBannerView!
    @IBOutlet weak var lblEmpty: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblHeader: UILabel!
    
    var projectId = Int()
    var projectHeaderName = String()
    
    var objCharacterViewModel = CharacterViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tblView.dataSource = self
        tblView.delegate = self
         AdBannerView.shared().objDelegate = self
         AdBannerView.shared().adsView(adsBannerView: adsBannerView, topview: self)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblHeader.text = projectHeaderName
       objCharacterViewModel.showCreateCharacter(tblView: tblView, projectId: projectId)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnSideMenuAction(_ sender: Any) {
        sideMenu.revealToggle(animated: true)
    }
    
    
    
    @IBAction func btnEditProjectAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddProjectVC") as! AddProjectVC
        vc.projectId = projectId
        vc.isEdit = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnAddCharacterAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateCharacterVC") as! CreateCharacterVC
        vc.projectId = projectId
        vc.projectHeaderName = projectHeaderName
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return objCharacterViewModel.numberOfSection(lblEmpty: lblEmpty)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return objCharacterViewModel.cellForRowAtIndex(tableView:tableView,indexPath:indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       objCharacterViewModel.didSelectRowAtIndex(topView: self, indexPath: indexPath, projectId: projectId)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
