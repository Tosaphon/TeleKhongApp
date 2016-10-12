//
//  storeObj.swift
//  TeleKhongApp
//
//  Created by NEXUS Mac on 21/10/58.
//  Copyright © พ.ศ. 2558 NEXUS Mac. All rights reserved.
//

import UIKit


class storeObj: NSObject,NSCoding {
    var storeName = ""
    var storeDetail = ""
    var storeAddress = ""
    var storeTel = ""
    var storeOpentime = ""
    var storePic = ""
    var storeId = ""
    var isFollow = false
    func toggleStatus(){
        isFollow = !isFollow
    }
    
    override init(){
        super.init()
    }
    
    required init? (coder aDecoder:NSCoder){
        storeName = aDecoder.decodeObject(forKey: "storeName") as! String
        storeDetail = aDecoder.decodeObject(forKey: "storeDetail") as! String
        storeAddress = aDecoder.decodeObject(forKey: "storeAddress") as! String
        storeTel = aDecoder.decodeObject(forKey: "storeTel") as! String
        storeOpentime = aDecoder.decodeObject(forKey: "storeOpentime") as! String
        storePic = aDecoder.decodeObject(forKey: "storePic") as! String
        storeId = aDecoder.decodeObject(forKey: "storeId") as! String
        isFollow = aDecoder.decodeBool(forKey: "isFollow")
        super.init()
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(storeName, forKey: "storeName")
        aCoder.encode(storeDetail, forKey: "storeDetail")
        aCoder.encode(storeAddress, forKey: "storeAddress")
        aCoder.encode(storeTel, forKey: "storeTel")
        aCoder.encode(storeOpentime, forKey: "storeOpentime")
        aCoder.encode(storePic, forKey: "storePic")
        aCoder.encode(storeId, forKey: "storeId")
        aCoder.encode(isFollow, forKey: "isFollow")
    }

    
    
}
