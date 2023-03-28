//
//  AlarmInfo+CoreDataProperties.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/28.
//
//

import Foundation
import CoreData


extension AlarmInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlarmInfo> {
        return NSFetchRequest<AlarmInfo>(entityName: "AlarmInfo")
    }

    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var location: String?
    @NSManaged public var week: String?
    @NSManaged public var time: String?
    @NSManaged public var times: String?
    @NSManaged public var radius: String?
    @NSManaged public var type: String?
    @NSManaged public var id: UUID?

}

extension AlarmInfo : Identifiable {

}
