//
//  InfoObj.swift
//  TeleKhongApp
//
//  Created by NEXUS Mac on 21/10/58.
//  Copyright © พ.ศ. 2558 NEXUS Mac. All rights reserved.
//

import UIKit

class InfoObj: NSObject,NSCoding {
    var infoId = ""
    var catagory = ""
    var infoBegin = ""
    var infoDesc = ""
    var infoExpire = ""
    var infoName = ""
    var infoPic = ""
    var storeId = ""
    var storeName = ""
    var qr = ""
    var detectTime = Date()
    var isFavorite = false
    
    func toggleStatus(){
        isFavorite = !isFavorite
    }
    
    override init(){
        super.init()
    }

    
    required init? (coder aDecoder:NSCoder){
        infoId = aDecoder.decodeObject(forKey: "infoId") as! String
        catagory = aDecoder.decodeObject(forKey: "catagory") as! String
        infoBegin = aDecoder.decodeObject(forKey: "infoBegin") as! String
        infoDesc = aDecoder.decodeObject(forKey: "infoDesc") as! String
        infoExpire = aDecoder.decodeObject(forKey: "infoExpire") as! String
        infoName = aDecoder.decodeObject(forKey: "infoName") as! String
        storeId = aDecoder.decodeObject(forKey: "storeId") as! String
        infoPic = aDecoder.decodeObject(forKey: "infoPic") as! String
        storeName = aDecoder.decodeObject(forKey: "storeName") as! String
        qr = aDecoder.decodeObject(forKey: "qr") as! String
        detectTime = aDecoder.decodeObject(forKey: "detectTime") as! Date
        isFavorite = aDecoder.decodeBool(forKey: "isFavorite")
        super.init()
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(infoId, forKey: "infoId")
        aCoder.encode(catagory, forKey: "catagory")
        aCoder.encode(infoBegin, forKey: "infoBegin")
        aCoder.encode(infoDesc, forKey: "infoDesc")
        aCoder.encode(infoExpire, forKey: "infoExpire")
        aCoder.encode(infoName, forKey: "infoName")
        aCoder.encode(storeId, forKey: "storeId")
        aCoder.encode(infoPic, forKey: "infoPic")
        aCoder.encode(storeName, forKey: "storeName")
        aCoder.encode(qr, forKey: "qr")
        aCoder.encode(detectTime, forKey: "detectTime")
        aCoder.encode(isFavorite, forKey: "isFavorite")
        
    }
}
