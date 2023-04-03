//
//  AlarmData+CoreDataProperties.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/04/03.
//
//

import Foundation
import CoreData


extension AlarmData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlarmData> {
        return NSFetchRequest<AlarmData>(entityName: "AlarmData")
    }

    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var location: String?
    @NSManaged public var times: String?
    @NSManaged public var radius: String?
    @NSManaged public var type: String?
    @NSManaged public var id: UUID?

}

extension AlarmData : Identifiable {

}
