//
//  khongObj.swift
//  TeleKhongApp
//
//  Created by NEXUS Mac on 22/10/58.
//  Copyright © พ.ศ. 2558 NEXUS Mac. All rights reserved.
//

import UIKit

class khongObj: NSObject,NSCoding {
    var uuid = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
    var major = ""
    var minor = ""
    var khongString = ""
    
    override init(){
        super.init()
    }
    
    required init? (coder aDecoder:NSCoder){
        uuid = aDecoder.decodeObject(forKey: "uuid") as! String
        major = aDecoder.decodeObject(forKey: "major") as! String
        minor = aDecoder.decodeObject(forKey: "minor") as! String
        khongString = aDecoder.decodeObject(forKey: "khongString") as! String
        super.init()
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uuid, forKey: "uuid")
        aCoder.encode(major, forKey: "major")
        aCoder.encode(minor, forKey: "minor")
        aCoder.encode(khongString, forKey: "khongString")
    }

}
