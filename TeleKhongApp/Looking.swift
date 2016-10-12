//
//  Looking.swift
//  TeleKhong
//
//  Created by Apple Macintosh on 6/21/15.
//  Copyright (c) 2015 SleepyJob. All rights reserved.
//

import UIKit

struct LookingObj{
    var name : String
    var status : Bool
    
}

struct settingObj {
    var text:String
    var checked:Bool
}

class Looking: NSObject {
    
//    func getData ()-> Array <LookingObj> {
//        var mTempArray = Array <LookingObj>()
//        //assign
//        let b1 = LookingObj(name: "Food", status: true)
//        mTempArray.append(b1)
//        let b2 = LookingObj(name: "Fashion", status: true)
//        mTempArray.append(b2)
//        let b3 = LookingObj(name: "Sport", status: true)
//        mTempArray.append(b3)
//        let b4 = LookingObj(name: "entertain", status: true)
//        mTempArray.append(b4)
//        let b5 = LookingObj(name: "book", status: true)
//        mTempArray.append(b5)
//        let b6 = LookingObj(name: "it", status: true)
//        mTempArray.append(b6)
//        let b7 = LookingObj(name: "healty", status: true)
//        mTempArray.append(b7)
//        
//        return mTempArray
//    }
    
    func getData() -> [settingItem]{
        var st = [settingItem]()
        
        _ = ["Food","Fashion","Sport","entertain","book","it","healty"]
        
        
        let a1 = settingItem()
        let a2 = settingItem()
        let a3 = settingItem()
        let a4 = settingItem()
        let a5 = settingItem()
        let a6 = settingItem()
        let a7 = settingItem()
        a1.text = "Food"
        a2.text = "Fashion"
        a3.text = "Sport"
        a4.text = "entertain"
        a5.text = "book"
        a6.text = "it"
        a7.text = "healty"
        
        st.append(a1)
        st.append(a2)
        st.append(a3)
        st.append(a4)
        st.append(a5)
        st.append(a6)
        st.append(a7)

        return st
    }
    
}
