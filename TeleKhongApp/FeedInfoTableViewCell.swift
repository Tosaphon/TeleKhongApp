//
//  FeedInfoTableViewCell.swift
//  TeleKhongApp
//
//  Created by NEXUS Mac on 10/10/58.
//  Copyright © พ.ศ. 2558 NEXUS Mac. All rights reserved.
//

import UIKit

protocol DeleteInfoDelegate {
    func deleteTapped(_ sender: AnyObject)
}

protocol FollowInfoDelegate {
    func followTapped(_ sender: AnyObject)
}
protocol FavoriteDelegate {
    func favoriteTapped(_ sender: AnyObject)
}
protocol ShareDelegate {
    func shareTapped(_ sender: AnyObject)
}
class FeedInfoTableViewCell: UITableViewCell {

    var deleteDelegate : DeleteInfoDelegate?
    var followDelegate : FollowInfoDelegate?
    var favoriteDelegate : FavoriteDelegate?
    var shareDelegate : ShareDelegate?
    
    
    let archive = archiveFunction()
    
    @IBOutlet weak var preQR: UIImageView!
    @IBOutlet weak var storePic: UIImageView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myInfo: UILabel!
    @IBOutlet weak var myDesc: UILabel!
    @IBOutlet weak var myStore: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var detectTime: UILabel!
    let c = 0
    
    @IBAction func deleteInfoButton(_ sender: AnyObject) {
        deleteDelegate?.deleteTapped(sender)
        
    }
    @IBAction func imageAction(_ sender: AnyObject) {
    }
    
    @IBAction func goToStore(_ sender: AnyObject) {

    }
    
    @IBAction func share(_ sender: AnyObject) {
        shareDelegate?.shareTapped(sender)
    }
    
    @IBAction func like(_ sender: AnyObject) {
    
        favoriteDelegate?.favoriteTapped(sender)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
