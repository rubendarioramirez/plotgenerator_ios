//
//  WeeklyChallengedParticipantVC.swift
//  Plot story assistant
//
//  Created by webastral on 26/06/19.
//  Copyright © 2019 webastral. All rights reserved.
//

import UIKit


class WeeklyChallengedParticipantVC: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollVew: UIScrollView!
    @IBOutlet weak var sliderVewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnMostVoted: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    
    //MARK:- Outlets
    var storyTitle: String = ""
    var story:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollVew.delegate = self
        let revealVC = revealViewController()
        btnMenu.addTarget(revealVC, action: #selector(revealVC?.revealToggle(_:)), for: .touchUpInside)
        
    }
    
    @IBAction func btnHeaders(_ sender: UIButton) {
        let dict = ["catagory": "\(sender.tag)"]
        NotificationCenter.default.post(name: Notification.Name("postNotifi"), object: nil, userInfo: dict)
        scrollVew.setCurrentPage(position: sender.tag)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        UIView.animate(withDuration: 0.1) {
            self.sliderVewLeadingConstraint.constant = self.btnMostVoted.frame.width * CGFloat(scrollView.currentPage)
            self.view.layoutIfNeeded()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let dict = ["catagory": "\(Int(scrollView.currentPage))"]
        NotificationCenter.default.post(name: Notification.Name("postNotifi"), object: nil, userInfo: dict)
    }
    
}
