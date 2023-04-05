//
//  AddViewModel.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/29.
//

class AddViewModel {
    // MARK: Internal Properties
    
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
}
