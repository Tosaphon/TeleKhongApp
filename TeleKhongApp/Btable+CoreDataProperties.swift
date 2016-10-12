//
//  Btable+CoreDataProperties.swift
//  TeleKhongApp
//
//  Created by NEXUS Mac on 27/9/58.
//  Copyright © พ.ศ. 2558 NEXUS Mac. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Btable {

    @NSManaged var beaconStr: String?
    @NSManaged var major: String?
    @NSManaged var minor: String?
    @NSManaged var uuid: String?

}
