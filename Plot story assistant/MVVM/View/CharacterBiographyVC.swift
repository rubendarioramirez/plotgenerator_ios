//
//  CharacterBiographyVC.swift
//  Plot story assistant
//
//  Created by webastral on 11/12/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CharacterBiographyVC: UIViewController,UITableViewDataSource,UITableViewDelegate{
   
    @IBOutlet weak var lblGuidetype: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var tblView: UITableView!
    var saveDataArray = [questionModel]()
    
    var bioId : Int = 0
    var isGender = String()
    var projectId : Int = 0
   
    var indexpath : Int = 0
    var charcterIndexpath : Int = 0
    var shareString : String = ""
   // var interstitial: GADInterstitial!
    
    var objCharacterBiographyViewModel = CharacterBiographyViewModel()
    
    var gameTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//       // interstitial = createAndLoadInterstitial()
//        AdBannerView.shared().objInterstitialDelegate = self
//
//        AdBannerView.shared().interstitial = AdBannerView.shared().createAndLoadInterstitial()
//
        
        // Do any additional setup after loading the view.
        tblView.dataSource = self
        tblView.delegate = self
        
        tblView.estimatedRowHeight = 50
        tblView.rowHeight = UITableViewAutomaticDimension
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToHomeSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        lblUserName.text = DataViewModel.shared().createCharacterArray[indexpath].username ?? ""
        lblGuidetype.text = DataViewModel.shared().createCharacterArray[indexpath].guideType ?? ""
        
     //   gameTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(showAds), userInfo: nil, repeats: true)
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(projectId)
        DataViewModel.shared().queryCreateCharacter(projectId: projectId) { (status) in
            DataViewModel.shared().showQuestTblData(bioId: self.bioId, tbl: self.tblView)
        }
        
       /* let decoder = JSONDecoder()
        if let questionData = UserDefaults.standard.data(forKey: "questDict\(bioId)"),
            let data = try? decoder.decode([questionModel].self, from: questionData) {
            saveDataArray = data
            print(saveDataArray)
        }*/
    }
    
//    @objc func showAds(){
//     objCharacterBiographyViewModel.interstitialShow(interstitial: AdBannerView.shared().interstitial, topView: self)
//     }
//    
//
//    func isDismiss(isTrue: Bool) {
//        gameTimer.invalidate()
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSideMenuAction(_ sender: Any) {
        sideMenu.revealToggle(animated: true)
    }
    
    
    @IBAction func btnchannelQuestAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChallengeVC") as! ChallengeVC
        vc.bioId = bioId
        vc.charcterIndexpath = indexpath
        vc.projectId = projectId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnGuideMeAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GuideMeVC") as! GuideMeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnShareAction(_ sender: Any) {
        
        let text = shareString
        let textShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
//        let text = "This is the text...."
//        let image = UIImage(named: "Product")
//        let myWebsite = NSURL(string:"https://stackoverflow.com/users/4600136/mr-javed-multani?tab=profile")
//        let shareAll= [text , image! , myWebsite]
//        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
//        activityViewController.popoverPresentationController?.sourceView = self.view
//        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func btnEditAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateCharacterVC") as! CreateCharacterVC
        vc.isEditRandomCharacter = true
        vc.bioId = bioId
        vc.projectId = projectId
        vc.indexpath = indexpath
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return UtilityMgr.bioArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return objCharacterBiographyViewModel.numberOfSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       return objCharacterBiographyViewModel.cellForRowAtIndex(tableView: tableView, indexPath: indexPath, topView: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    

}
