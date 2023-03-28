//
//  CoreDataProcessable.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/28.
//

import UIKit
import CoreData

protocol CoreDataProcessable {
    func saveCoreData(alarm: AlarmInformation) -> Result<Bool, CoreDataError>
    func readCoreData() -> Result<[AlarmInfo], CoreDataError>
    func updateCoreData(alarm: AlarmInformation) -> Result<Bool, CoreDataError>
    func deleteCoreData(alarm: AlarmInformation) -> Result<Bool, CoreDataError>
}

extension CoreDataProcessable {
    func saveCoreData(alarm: AlarmInformation) -> Result<Bool, CoreDataError> {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return .failure(.appDelegateError)
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(
            forEntityName: "AlarmInfo",
            in: managedContext
        ) else {
            return .failure(.entityError)
        }
        
        let object = NSManagedObject(entity: entity, insertInto: managedContext)
        
        object.setValue(alarm.id, forKey: "id")
        object.setValue(alarm.type, forKey: "type")
        object.setValue(alarm.location, forKey: "location")
        object.setValue(alarm.latitude, forKey: "latitude")
        object.setValue(alarm.longitude, forKey: "longitude")
        object.setValue(alarm.week, forKey: "week")
        object.setValue(alarm.time, forKey: "time")
        object.setValue(alarm.radius, forKey: "radius")
        object.setValue(alarm.times, forKey: "times")
        
        do {
            try managedContext.save()
            return .success(true)
        } catch {
            return .failure(.saveError)
        }
    }
    
    func readCoreData() -> Result<[AlarmInfo], CoreDataError> {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return .failure(.appDelegateError)
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<AlarmInfo>(entityName: "AlarmInfo")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            return .success(result)
        } catch {
            return .failure(.fetchError)
        }
    }
    
    func updateCoreData(alarm: AlarmInformation) -> Result<Bool, CoreDataError> {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return .failure(.appDelegateError)
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "AlarmInfo")
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", alarm.id.uuidString)
        
        guard let result = try? managedContext.fetch(fetchRequest),
              let object = result.first as? NSManagedObject
        else {
            return .failure(.fetchError)
        }
        
        object.setValue(alarm.id, forKey: "id")
        object.setValue(alarm.type, forKey: "type")
        object.setValue(alarm.location, forKey: "location")
        object.setValue(alarm.latitude, forKey: "latitude")
        object.setValue(alarm.longitude, forKey: "longitude")
        object.setValue(alarm.week, forKey: "week")
        object.setValue(alarm.time, forKey: "time")
        object.setValue(alarm.radius, forKey: "radius")
        object.setValue(alarm.times, forKey: "times")
        
        do {
            try managedContext.save()
            return .success(true)
        } catch {
            return .failure(.saveError)
        }
    }
    
    func deleteCoreData(alarm: AlarmInformation) -> Result<Bool, CoreDataError> {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return .failure(.appDelegateError)
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "AlarmInfo")
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", alarm.id.uuidString)
        
        guard let result = try? managedContext.fetch(fetchRequest),
              let objectToDelete = result.first as? NSManagedObject
        else {
            return .failure(.fetchError)
        }
        
        managedContext.delete(objectToDelete)
            
        do {
            try managedContext.save()
            return .success(true)
        } catch {
            return .failure(.saveError)
        }
    }
}
