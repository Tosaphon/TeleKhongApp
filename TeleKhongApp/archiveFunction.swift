//
//  archriveFunction.swift
//  TeleKhongApp
//
//  Created by NEXUS Mac on 23/10/58.
//  Copyright © พ.ศ. 2558 NEXUS Mac. All rights reserved.
//

import UIKit

class archiveFunction: NSObject {
    
    func documentDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths[0]
    }
    
    func saveInfoItems(){
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(infoLists, forKey: "infoItems")
        archiver.finishEncoding()
        data.write(toFile: dataFilePathForInfo(), atomically: true)
    }
    func saveStoreItem(){
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(storeLists, forKey: "storeItem")
        archiver.finishEncoding()
        data.write(toFile: dataFilePathForStore(), atomically: true)
    }
    func saveKhong(){
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(khongLists, forKey: "khongLists")
        archiver.finishEncoding()
        data.write(toFile: dataFilePathForKhong(), atomically: true)
    }
    func saveProfile(){
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(profile, forKey: "facebookProfile")
        archiver.finishEncoding()
        data.write(toFile: dataFilePathForProfile(), atomically: true)
    }
    func saveFavorite(){
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(favoriteLists, forKey: "favoriteLists")
        archiver.finishEncoding()
        data.write(toFile: dataFilePathForFavorite(), atomically: true)
    }
    func saveFollow(){
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(followLists, forKey: "followLists")
        archiver.finishEncoding()
        data.write(toFile: dataFilePathForFollow(), atomically: true)
    }
    func saveChecklistItems(){
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(items, forKey: "ChecklistItems")
        archiver.finishEncoding()
        data.write(toFile: dataFilePathForChecklistItem(), atomically: true)
    }
    
    
    func dataFilePathForInfo() -> String{
        let sDocument = documentDirectory() as NSString
        return sDocument.appendingPathComponent("infoItems.plist")
    }
    func dataFilePathForProfile() -> String{
        let sDocument = documentDirectory() as NSString
        return sDocument.appendingPathComponent("facebookProfile.plist")
    }
    func dataFilePathForKhong() -> String{
        let sDocument = documentDirectory() as NSString
        return sDocument.appendingPathComponent("khongLists.pList")
    }
    func dataFilePathForStore() -> String{
        let sDocument = documentDirectory() as NSString
        return sDocument.appendingPathComponent("storeItem.plist")
    }
    func dataFilePathForFavorite() -> String{
        let sDocument = documentDirectory() as NSString
        return sDocument.appendingPathComponent("favoriteItem.plist")
    }
    func dataFilePathForFollow() -> String{
        let sDocument = documentDirectory() as NSString
        return sDocument.appendingPathComponent("followItem.plist")
    }
    func dataFilePathForChecklistItem() -> String{
        let sDocument = documentDirectory() as NSString
        
        return sDocument.appendingPathComponent("Checklist.plist")
    }
    
    func loadInfoItems(){
        let path = dataFilePathForInfo()
        if FileManager.default.fileExists(atPath: path){
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)){
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                infoLists = unarchiver.decodeObject(forKey: "infoItems") as! [InfoObj]
                unarchiver.finishDecoding()
            }
        }
    }
    func loadStoreItem(){
        let path = dataFilePathForStore()
        if FileManager.default.fileExists(atPath: path){
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)){
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                storeLists = unarchiver.decodeObject(forKey: "storeItem") as! [storeObj]
                unarchiver.finishDecoding()
            }
        }
    }
    func loadProfile(){
        let path = dataFilePathForProfile()
        if FileManager.default.fileExists(atPath: path){
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)){
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                profile = unarchiver.decodeObject(forKey: "facebookProfile") as! [facebookProfile]
                unarchiver.finishDecoding()
            }
        }
    }
    func loadKhong(){
        let path = dataFilePathForKhong()
        if FileManager.default.fileExists(atPath: path){
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)){
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                khongLists = unarchiver.decodeObject(forKey: "khongLists") as! [khongObj]
                unarchiver.finishDecoding()
            }
        }
    }
    func loadFavorite(){
        let path = dataFilePathForFavorite()
        if FileManager.default.fileExists(atPath: path){
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)){
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                favoriteLists = unarchiver.decodeObject(forKey: "favoriteLists") as! [InfoObj]
                unarchiver.finishDecoding()
            }
        }
    }
    func loadFollow(){
        let path = dataFilePathForFollow()
        if FileManager.default.fileExists(atPath: path){
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)){
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                followLists = unarchiver.decodeObject(forKey: "followLists") as! [storeObj]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func loadChecklistItems(){
        let path = dataFilePathForChecklistItem()
        if FileManager.default.fileExists(atPath: path){
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)){
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                items = unarchiver.decodeObject(forKey: "ChecklistItems") as! [settingItem]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func loadAll(){
        loadKhong()
        loadStoreItem()
        loadInfoItems()
    }
    func saveAll(){
        saveInfoItems()
        saveStoreItem()
        saveKhong()
    }

}
