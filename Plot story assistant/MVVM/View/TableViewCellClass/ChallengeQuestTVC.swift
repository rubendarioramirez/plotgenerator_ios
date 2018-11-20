//
//  ChallengeQuestTVC.swift
//  Plot story assistant
//
//  Created by webastral on 11/3/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ChallengeQuestTVC: UITableViewCell {
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var txtAnswer: IQTextView!
    
    @IBOutlet weak var lblBottom: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
