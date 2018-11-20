//
//  HeroJourneyTVC.swift
//  Plot story assistant
//
//  Created by webastral on 11/2/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit

class HeroJourneyTVC: UITableViewCell {

    @IBOutlet weak var imgChallengeBackground: UIImageView!
    @IBOutlet weak var imgGuideBackground: UIImageView!
    @IBOutlet weak var imgBackGround: UIImageView!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblHeading: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
