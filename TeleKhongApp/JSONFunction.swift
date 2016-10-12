//
//  JSONFunction.swift
//  TeleKhongApp
//
//  Created by NEXUS Mac on 27/9/58.
//  Copyright © พ.ศ. 2558 NEXUS Mac. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

var storeLists = [storeObj]()
var infoLists = [InfoObj]()
var favoriteLists = [InfoObj]()
var followLists = [storeObj]()


class JSONFunction: NSObject{
    var st_id : String = ""
    
    func getTime() -> String{
        let date = Date();
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMM d, h:mm a")
        let localDate = dateFormatter.string(from: date)
        return localDate
    }

    
    func jsonInfo(_ major:String,minor:String,id:String){
        let parameters: [String: String] = ["uuid":"B9407F30-F5F8-466E-AFF9-25556B57FE6D","major":major,"minor":minor,"fb_id":id]
        
        Alamofire.request(.POST, "http://telekhong.me.ipv4.sixxs.org/index.php/json/appback/findinfo", parameters: parameters)
            .responseJSON { response in
                if let json = response.result.value{
                    if json.count != 0 {
                    let infoObj = InfoObj()
                    if let infoName = json["info_name"]{
                        infoObj.infoName = infoName as! String
//                        print("info name (json) : " + String(infoName))
                    }
                    if let infoId = json["info_id"]{
                        infoObj.infoId = infoId as! String
                        print("info id (json) : " + String(infoId))
                    }
                    if let infoBegin = json["info_begin"]{
                        infoObj.infoBegin = infoBegin as! String
//                        print("infoBegin(json) : " + String(infoBegin))
                    }
                    if let infoDesc = json["info_desc"]{
                        infoObj.infoDesc = infoDesc as! String
//                        print("infoDesc(json) : " + String(infoDesc))
                    }
                    if let infoExpire = json["info_expire"]{
                        infoObj.infoExpire = infoExpire as! String
//                        print("infoExpire(json) : " + String(infoExpire))
                    }
                    if let catagory = json["catagory"]{
                        infoObj.catagory = catagory as! String
//                        print("catagory (json) : " + String(catagory))
                    }
                    if let storeId = json["store_id"]{
                        infoObj.storeId = storeId as! String
//                        print("storeId(json) : " + String(storeId))
                    }
                    if let storeName = json["store_name"]{
                        infoObj.storeName = storeName as! String
//                        print("storeName (json) : " + String(storeName))
                    }
                    if let qr = json["qr"]{
//                        infoObj.qr = qr as! String
                        print("qr (json) : " + String(qr))
                        let isQR = qr as! String
                        if isQR == "have"{
                            print(infoLists.count)
                            self.jsonQR(fb_id, infoId: infoObj.infoId,index:infoLists.count)
                        }else{
                            infoObj.qr = "nil"
                        }
                    }
                    if let url = json["info_pic"]{
                        let picUrl = "http://www.telekhong.me.ipv4.sixxs.org/images/info/" + String(url)
                        infoObj.infoPic = picUrl
//                        print("picUrl (json) : " + String(picUrl))
                    }
                        
                    infoLists.append(infoObj)
                    self.jsonStore(infoObj.storeId)
                }
            }
            
        }
    }
    
//    func jsonInfo2(id:String){
//        let parameters: [String: String] = ["uuid":"sdfsdfslafm","major":"asaaa","minor":"ertrgf","fb_id":"1176771389006354"]
//        
//        Alamofire.request(.POST, "http://telekhong.me.ipv4.sixxs.org/index.php/json/appback/findinfo2", parameters: parameters)
//            .responseJSON { response in
//                if let JSON = response.result.value {
//
//                    let aIndex = JSON.count
//                    if aIndex > 0 {
//                        for index in 0...aIndex-1{
////                            print(index)
////                            print(JSON)
////                            if let jsonResult = JSON{
////                                if let id = jsonResult["info_id"] as? String{
////                                    print(id)
////                                }
////                                if let img = jsonResult["info_pic"] as? String{
////                                    print(img)
////                                }
////                                if let name = jsonResult["info_name"] as? String{
////                                    print(name)
////                                }
////                            }//jsonResult
////                            
//                        }//for loop
//                        
//                    }//aIndex>0
//                    
//                }//if let JSON
//
//        }
//        
//    }
    


    
    func jsonStore(_ id:String){
        Alamofire.request(.POST, "http://telekhong.me.ipv4.sixxs.org/index.php/json/appback/storedetail", parameters: ["storeid":id])
            .responseJSON { response in
                if let json = response.result.value{
                    
                    let stObj = storeObj()
                    if let storeId = json["id"]{
                        stObj.storeId = storeId as! String
                    }
                    if let storeName = json["storename"]{
                        stObj.storeName = storeName as! String
                        print(stObj.storeName)
                    }
                    if let storeDetail = json["detail"]{
                        stObj.storeDetail = storeDetail as! String
                    }
                    if let storeAddress = json["address"]{
                        stObj.storeAddress = storeAddress as! String
                    }
                    if let storeTel = json["tel"]{
                        stObj.storeTel = storeTel as! String
                    }
                    if let storeOpentime = json["opentime"]{
                        stObj.storeOpentime = storeOpentime as! String
                    }
                    if let storePic = json["pic"]{
                        let picUrl = "http://www.telekhong.me.ipv4.sixxs.org/images/store/" + String(storePic)
                        stObj.storePic = picUrl
                    }
                    
                    storeLists.append(stObj)
                }
                
        }
    }
    func jsonQR(_ fbId:String,infoId:String,index:Int){
        print(fb_id)
        let param : [String : String] = ["fb":fbId,"info":infoId]
        Alamofire.request(.POST, "http://telekhong.me.ipv4.sixxs.org/index.php/json/appback/qrcode", parameters: param)
            .responseJSON { response in
                print(response.result.value)
                if let json = response.result.value{
//                    print(json)
                    if let qrcode = json["qrcode"]{
                        print(qrcode)
                        infoLists[index].qr = qrcode as! String
                    }
                }
        }
    }
    
    func jsonSetting(_ id:String,food:Int,fashion:Int,sport:Int,entertain:Int,book:Int,it:Int,healty:Int){
        let param = ["id":id,"food":food,"fashion":fashion,"sport":sport,"entertain":entertain,"book":book,"it":it,"healty":healty] as [String : Any]
        Alamofire.request(.POST, "http://telekhong.me.ipv4.sixxs.org/index.php/json/appback/setapp", parameters: param as? [String : AnyObject])
            .responseJSON { response in
                if let json = response.result.value{
                    if let settingStatus = json["status"]{
                        print(settingStatus)
                    }
                }
        }
    }
    
    func jsonFollow(fb_id:String,store_id:String){
        let param = ["fb_id":fb_id,"store_id":store_id]
        Alamofire.request(.POST, "http://telekhong.me.ipv4.sixxs.org/index.php/json/appback/follow", parameters: param)
            .responseJSON { response in
                if let json = response.result.value{
                    if let settingStatus = json["status"]{
                        print(settingStatus)
                    }
                }
        }
    }
    func jsonFavorite(fb_id:String,info_id:String){
        let param = ["fb_id":fb_id,"info_id":info_id]
        Alamofire.request(.POST, "http://telekhong.me.ipv4.sixxs.org/index.php/json/appback/fav", parameters: param)
            .responseJSON { response in
                if let json = response.result.value{
                    if let settingStatus = json["status"]{
                        print(settingStatus)
                    }
                }
        }
    }
    
    func jsonCheckLogin(_ id:String){
        let param : [String : String] = ["id":id]
        Alamofire.request(.POST, "http://telekhong.me.ipv4.sixxs.org/index.php/json/appback/checkuserinfo", parameters: param )
            .responseJSON { response in
                if let json = response.result.value{
                    if let s : Bool = json["status"] as? Bool{
                        status = String(s)
                        print("Check Login Sucess")
                        print("Status is : " + String(s))
                    }
                }
        }
    }
    func jsonLogin(_ id:String , gender:String, birth:String , name:String){
        var i = [String]()
        let looking = Looking()
        let param : [String : String] = ["id":id,"gender":gender,"birth":birth,"name":name]
        Alamofire.request(.POST, "http://telekhong.me.ipv4.sixxs.org/index.php/json/appback/login", parameters: param )
            .responseJSON { response in
                print("id : " + id)
                print("name : " + name)
                if let json = response.result.value{
                    items = looking.getData()
                    if let food = json["food"] as? NSString{
                        i.append(food as String)
                    }
                    if let fashion = json["fashion"] as? NSString{
                        i.append(fashion as String)
                    }
                    if let sport = json["sport"] as? NSString{
                        i.append(sport as String)
                    }
                    if let entertain = json["entertain"] as? NSString{
                        i.append(entertain as String)
                    }
                    if let book = json["book"] as? NSString{
                        i.append(book as String)
                    }
                    if let it = json["it"] as? NSString{
                        i.append(it as String)
                    }
                    if let healty = json["healty"] as? NSString{
                        i.append(healty as String)
                    }
                    for index in 0...6{
                        if i[index] == "1" {
                            items[index].checked = true
                        }else{
                            items[index].checked = false
                        }
                        print("\(items[index].text)" + " : " + "\(items[index].checked)")
                    }
                    
                }
        }
    }
    
    
}

extension UIImageView {
    func downloadedFrom(link:String) {
//        contentMode = mode
        if let url = URL(string: link) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) -> Void in
                guard let data = data , error == nil else { return }
                DispatchQueue.main.async { () -> Void in self.image = UIImage(data: data)}
            }).resume()
        }
    }
}
extension Date {
    func yearsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.year, from: date, to: self, options: []).year!
    }
    func monthsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.month, from: date, to: self, options: []).month!
    }
    func weeksFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.weekOfYear, from: date, to: self, options: []).weekOfYear!
    }
    func daysFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.day, from: date, to: self, options: []).day!
    }
    func hoursFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.hour, from: date, to: self, options: []).hour!
    }
    func minutesFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.minute, from: date, to: self, options: []).minute!
    }
    func secondsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.second, from: date, to: self, options: []).second!
    }
    func offsetFrom(_ date:Date) -> String {
        if yearsFrom(date)   > 0 { return "\(yearsFrom(date))y"   }
        if monthsFrom(date)  > 0 { return "\(monthsFrom(date))M"  }
        if weeksFrom(date)   > 0 { return "\(weeksFrom(date))w"   }
        if daysFrom(date)    > 0 { return "\(daysFrom(date))d"    }
        if hoursFrom(date)   > 0 { return "\(hoursFrom(date))h"   }
        if minutesFrom(date) > 0 { return "\(minutesFrom(date))m" }
        if secondsFrom(date) > 0 { return "\(secondsFrom(date))s" }
        return ""
    }
}
