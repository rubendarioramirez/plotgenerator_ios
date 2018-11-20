//
//  CharacterBiographyTVC.swift
//  Plot story assistant
//
//  Created by webastral on 11/12/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit

class CharacterBiographyTVC: UITableViewCell {

    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var lblBio: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
