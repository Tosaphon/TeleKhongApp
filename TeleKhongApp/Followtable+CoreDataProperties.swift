//
//  Followtable+CoreDataProperties.swift
//  TeleKhongApp
//
//  Created by NEXUS Mac on 14/10/58.
//  Copyright © พ.ศ. 2558 NEXUS Mac. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Followtable {

    @NSManaged var address: String?
    @NSManaged var detail: String?
    @NSManaged var id: String?
    @NSManaged var name: String?
    @NSManaged var opentime: String?
    @NSManaged var pic: String?
    @NSManaged var tel: String?

}