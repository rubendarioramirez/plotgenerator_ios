//
//  SideBarVC.swift
//  Footsii
//
//  Created by webastral on 11/08/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit
import SWRevealViewController

class SideBarVC: UIViewController {
    
    @IBOutlet weak var tblSideBar: UITableView!
    
    var window: UIWindow?
    
     let arrLbls = ["Character Workshop","Writing prompts","The hero journey","Weekly writing challenge"]
    
     let imgArr : [UIImage] = [#imageLiteral(resourceName: "SideMenuAccount"),#imageLiteral(resourceName: "SideMenuBolt"),#imageLiteral(resourceName: "SideMenuBook"),#imageLiteral(resourceName: "SideMenuWritor")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        tblSideBar.delegate = self
        tblSideBar.dataSource = self
        
        if #available(iOS 11, *) {
            self.tblSideBar.contentInsetAdjustmentBehavior = .never;
        }else{
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeRight)
        
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            //case UISwipeGestureRecognizerDirection.left:
             //   dismissDetail()
            default:
                break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension SideBarVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLbls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tblSideBar.dequeueReusableCell(withIdentifier: "cell") as! SideBarTVC
        cell.lblTitle.text = arrLbls[indexPath.row]
        cell.imgTitle.image = imgArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 55
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let revealController: SWRevealViewController? = revealViewController()
        var newFrontController: UIViewController? = nil
        
        if indexPath.row == 0{
            newFrontController = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        }
        else if indexPath.row == 1 {
            newFrontController = storyboard?.instantiateViewController(withIdentifier: "WritingPromptsVC") as! WritingPromptsVC
        }
        else if indexPath.row == 2{
          newFrontController = storyboard?.instantiateViewController(withIdentifier: "HeroJourneyVC") as! HeroJourneyVC
        }else if indexPath.row == 3{
            newFrontController = storyboard?.instantiateViewController(withIdentifier: "WeeklyChallengeVC") as! WeeklyChallengeVC
        }
        let navigation = UINavigationController(rootViewController: newFrontController!)
        navigation.isNavigationBarHidden = true
        revealController?.pushFrontViewController(navigation, animated: true)
    }
    
    
    func pushController(identifier:String){
        let story = UIStoryboard(name: "Main", bundle: nil)
        let frontVC = story.instantiateViewController(withIdentifier: identifier)
        let frontNav = UINavigationController(rootViewController: frontVC)
        frontNav.isNavigationBarHidden = true
        let rearNav = UINavigationController(rootViewController: story.instantiateViewController(withIdentifier: "SideBarVC"))
        let revealController = SWRevealViewController(rearViewController: rearNav, frontViewController: frontNav)
        sideMenu = revealController!
        window?.rootViewController = sideMenu
        window?.makeKeyAndVisible()
    }
    
    
}

