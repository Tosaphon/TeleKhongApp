//
//  Favtable+CoreDataProperties.swift
//  TeleKhongApp
//
//  Created by SleepyJob on 9/29/2558 BE.
//  Copyright © 2558 NEXUS Mac. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Favtable {

    @NSManaged var catagory: String?
    @NSManaged var info_begin: String?
    @NSManaged var store_id: String?
    @NSManaged var info_desc: String?
    @NSManaged var store_name: String?
    @NSManaged var info_expire: String?
    @NSManaged var info_name: String?
    @NSManaged var info_pic: String?
    @NSManaged var info_id: String?

}
