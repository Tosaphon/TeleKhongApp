//
//  facebookProfile.swift
//  TeleKhongApp
//
//  Created by NEXUS Mac on 23/10/58.
//  Copyright © พ.ศ. 2558 NEXUS Mac. All rights reserved.
//

import UIKit

class facebookProfile: NSObject ,NSCoding{
    var id = ""
    var name = ""
    var gender = ""
    var birth = ""
    
    override init(){
        super.init()
    }
    
    required init? (coder aDecoder:NSCoder){
        id = aDecoder.decodeObject(forKey: "id") as! String
        name = aDecoder.decodeObject(forKey: "name") as! String
        gender = aDecoder.decodeObject(forKey: "gender") as! String
        birth = aDecoder.decodeObject(forKey: "birth") as! String
        
        super.init()
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(gender, forKey: "gender")
        aCoder.encode(birth, forKey: "birth")
    }
}
