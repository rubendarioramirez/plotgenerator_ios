//
//  CommentVCCell.swift
//  Plot story assistant
//
//  Created by webastral on 28/06/19.
//  Copyright © 2019 webastral. All rights reserved.
//

import UIKit

class CommentVCCell: UITableViewCell {


    @IBOutlet weak var imgProfile: ImageCustom!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblCommentDesc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
