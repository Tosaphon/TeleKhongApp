//
//  BLEManager.swift
//  TeleKhongApp
//
//  Created by NEXUS Mac on 26/9/58.
//  Copyright © พ.ศ. 2558 NEXUS Mac. All rights reserved.
//
import CoreBluetooth
import CoreLocation
import UIKit
import CoreData
import UIKit


var majors = [String]()
var minors = [String]()
var isSuccess = Bool()
var bStr = [String]()
var khongLists = [khongObj]()

class BLEManager {
    var centralManager : CBCentralManager!
    var bleHandler : BLEHandler
    
    init(){
        self.bleHandler = BLEHandler()
        self.centralManager = CBCentralManager(delegate: self.bleHandler, queue: nil,options: nil)
    }
    
}

class BLEHandler : NSObject,CBCentralManagerDelegate{
    override init() {
        super.init()
    }
    
    var c = 0

    
    var uuid = ""
    var endUUID = "23A01AF0-232A-4518-9C0E-323FB773F5EF"
    var endMajor = ""
    var endMinor = ""
    var beaconString = ""

    
    let jsonFung :JSONFunction = JSONFunction()
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch(central.state){
        case .unsupported:
            print("BLE is unsupported")
        case .unauthorized:
            print("BLE is unauthorized")
        case .unknown:
            print("BLE is unknown")
        case .resetting:
            print("BLE is powered off")
        case .poweredOn:
            print("BLE is powered on")
            print("Start Scanning")
            central.scanForPeripherals(withServices: nil, options: nil)
        default:
            print("BLE default")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
//        load()
        isSuccess = false
        
        
        print("count : " + String(c++))
        
//         if !contains(bStr, element: uuid){
        
        if let adData = advertisementData["kCBAdvDataServiceData"]{
            
            let a = String(describing: adData)
            
            let mString = a.substring(with: (a.characters.index(a.startIndex, offsetBy: 14) ..< a.characters.index(a.startIndex, offsetBy: 65)))
            endMajor = mString.substring(with: (mString.characters.index(mString.startIndex, offsetBy: 18) ..< mString.characters.index(mString.startIndex, offsetBy: 22)))
            
            endMinor = mString.substring(with: (mString.characters.index(mString.startIndex, offsetBy: 22) ..< mString.characters.index(mString.startIndex, offsetBy: 26)))
            beaconString = endMajor + endMinor
            print(bStr)
            print("endMajor : " + endMajor)
            print("endMinor : " + endMinor)
            print("beaconString : " + beaconString)
            
            if !contains(bStr, element: beaconString){
                bStr.append(beaconString)
            if !(bStr.isEmpty){
                saveData(beaconString, major: endMajor, minor: endMinor)
                print("new saved")
                jsonFung.jsonInfo(endMajor, minor: endMinor, id: fb_id)
            }
            }else{
                print("duplicate")
            }
            
                print("------------------------------")

        }
        
}
    
    
    func contains(_ values: [String], element: String) -> Bool {
        // Loop over all values in the array.
        for value in values {
            // If a value equals the argument, return true.
            if value == element {
                return true
            }
        }
        // The element was not found.
        return false
    }
    
    func saveData(_ beaconString:String, major:String, minor:String){
        let khong = khongObj()
        khong.major = major
        khong.minor = minor
        khong.khongString = beaconString
        khongLists.append(khong)
    }

  
    
    
    
    func uniq<S : Sequence, T : Hashable>(_ source: S) -> [T] where S.Iterator.Element == T {
        var buffer = [T]()
        var added = Set<T>()
        for elem in source {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
    
}


extension String {
    func replace(_ string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(" ", replacement: "")
    }
    func replaceWhitespace() -> String {
        return self.replace(" ", replacement: "-")
    }
}
