//
//  RecentVCCell.swift
//  Plot story assistant
//
//  Created by webastral on 26/06/19.
//  Copyright © 2019 webastral. All rights reserved.
//

import UIKit

class RecentVCCell: UITableViewCell {

    @IBOutlet weak var backVew: UIView!
    @IBOutlet weak var lblProfileName: UILabel!
    @IBOutlet weak var imgProfilePIc: ImageCustom!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblStory: UILabel!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var imgLikeUnlike: UIImageView!
    @IBOutlet weak var btnLikeUnlike: UIButton!
    @IBOutlet weak var lblCommentCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 15
        backVew.layer.cornerRadius = 15
    }

    @IBAction func btnLikeUnlike(_ sender: UIButton) {
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

         
    }

}
