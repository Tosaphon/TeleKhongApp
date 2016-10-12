//
//  Identify.swift
//  TeleKhongApp
//
//  Created by NEXUS Mac on 14/11/58.
//  Copyright © พ.ศ. 2558 NEXUS Mac. All rights reserved.
//

import UIKit
import Alamofire

class Identify {
    
    var id = ""
    
    init(id:String){
        self.id = id
    }
    
    func login(_ callback: ((_ isOk: Bool)->Void)?){
        let param : [String : String] = ["id":id]
        Alamofire.request(.POST, "http://telekhong.me.ipv4.sixxs.org/index.php/json/appback/checkuserinfo", parameters: param)
            .responseJSON { response in
                if let json = response.result.value{
                    if let s : Bool = json["status"] as? Bool{
                        status = String(s)
                        print("Check Login Sucess")
//                        print("Status is : " + String(s))
                        if s == true{
                            callback?(isOk: true)
                        }else{
                            callback?(isOk: false)
                        }
                        
                    }
                }
        }
        
    }
    
}
