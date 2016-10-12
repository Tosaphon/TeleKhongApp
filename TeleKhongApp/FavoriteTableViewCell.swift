//
//  FavoriteTableViewCell.swift
//  TeleKhongApp
//
//  Created by NEXUS Mac on 25/10/58.
//  Copyright © พ.ศ. 2558 NEXUS Mac. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var infoPic: UIImageView!
    @IBOutlet weak var infoName: UILabel!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var infoDesc: UILabel!
    @IBOutlet weak var expireDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
