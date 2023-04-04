//
//  AddViewModel.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/29.
//

class AddViewModel {
    var alarmInformation: [String: String] = [:]
}

// MARK: - CoreDataProcessable

extension AddViewModel: CoreDataProcessable {
    func save(alarm: AlarmInformation) {
        let result = saveCoreData(alarm: alarm)
        
        switch result {
        case .success(_):
            break
        case .failure(let error):
            print(error)
        }
    }
    
    func update(alarm: AlarmInformation) {
        let result = updateCoreData(alarm: alarm)
        
        switch result {
        case .success(_):
            break
        case .failure(let error):
            print(error)
        }
    }
    
    func delete(alarm: AlarmInformation) {
        let result = deleteCoreData(alarm: alarm)
        
        switch result {
        case .success(_):
            break
        case .failure(let error):
            print(error)
        }
    }
    
    func fetchDiaryData() -> [AlarmData]? {
        let result = readCoreData()
        
        switch result {
        case .success(let entity):
            return entity
        case .failure(_):
            return nil
        }
    }
}
