//
//  LookingForTableViewCell.swift
//  TeleKhongApp
//
//  Created by NEXUS Mac on 21/10/58.
//  Copyright © พ.ศ. 2558 NEXUS Mac. All rights reserved.
//

import UIKit

protocol CustomCellDelegate {
    func cellButtonTapped(_ cell: LookingForTableViewCell)
}

class LookingForTableViewCell: UITableViewCell {
    
    @IBOutlet weak var settingName: UILabel!
    @IBOutlet weak var mySwitcher: UISwitch!
    var delegate: CustomCellDelegate?
    
    
    @IBAction func switcher(_ sender: AnyObject) {
//        let index = sender.index
//        let item = items[index]
//        item.toggleChecked()
//        items[index] = item
//        saveChecklistItems()
        delegate?.cellButtonTapped(self)
    }
    
    func saveChecklistItems(){
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(items, forKey: "ChecklistItems")
        archiver.finishEncoding()
        data.write(toFile: dataFilePath(), atomically: true)
    }
    
    func documentDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths[0]
    }
    func dataFilePath() -> String{
        let sDocument = documentDirectory() as NSString
        
        return sDocument.appendingPathComponent("Checklist.plist")
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
