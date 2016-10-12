//
//  settingItem.swift
//  TeleKhong
//
//  Created by NEXUS Mac on 25/9/58.
//  Copyright © พ.ศ. 2558 NEXUS Mac. All rights reserved.
//

import UIKit


class settingItem: NSObject,NSCoding {
    var text = ""
    var checked = false
    func toggleChecked(){
        checked = !checked
    }
    
    override init(){
        super.init()
    }
    
    required init? (coder aDecoder:NSCoder){
        text = aDecoder.decodeObject(forKey: "Text") as! String
        checked = aDecoder.decodeBool(forKey: "Checked")
        super.init()
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")
    }
}
