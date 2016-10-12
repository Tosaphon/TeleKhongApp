//
//  FollowTableViewCell.swift
//  TeleKhongApp
//
//  Created by NEXUS Mac on 25/10/58.
//  Copyright © พ.ศ. 2558 NEXUS Mac. All rights reserved.
//

import UIKit

class FollowTableViewCell: UITableViewCell {

    @IBOutlet weak var storePic: UIImageView!
    @IBOutlet weak var storeName: UILabel!
    
    @IBOutlet weak var StoreDesc: UILabel!
    @IBOutlet weak var openTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
