//
//  Subtable+CoreDataProperties.swift
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

extension Subtable {

    @NSManaged var address: String?
    @NSManaged var detail: String?
    @NSManaged var id: String?
    @NSManaged var tel: String?
    @NSManaged var pic: String?
    @NSManaged var opentime: String?
    @NSManaged var name: String?

}
