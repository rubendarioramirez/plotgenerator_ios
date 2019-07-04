//
//  WeeklyWrittingContainer.swift
//  Plot story assistant
//
//  Created by webastral on 27/06/19.
//  Copyright © 2019 webastral. All rights reserved.
//

import UIKit

class WeeklyWrittingContainer: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollVew: UIScrollView!
    @IBOutlet weak var sliderLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnOnGoing: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollVew.delegate = self
        
    }

    @IBAction func btnHeaders(_ sender: UIButton) {
        scrollVew.setCurrentPage(position: sender.tag)
    }
    @IBAction func btnSideMenuAction(_ sender: Any) {
        sideMenu.revealToggle(animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.1) {
            self.sliderLeadingConstraint.constant = self.btnOnGoing.frame.width * CGFloat(scrollView.currentPage)
            self.view.layoutIfNeeded()
        }
    }
}
