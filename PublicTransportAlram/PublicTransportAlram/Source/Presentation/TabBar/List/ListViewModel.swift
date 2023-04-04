//
//  ListViewModel.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/05.
//

import Foundation
import RxSwift
import RxCocoa

class ListViewModel {
    
    let disposeBag = DisposeBag()
    
    var alarmList: [AlarmInformation] = []
    var alarm: [String: String] = [:]
    
    func convertToDiary(from dataArray: [AlarmData]) -> [AlarmInformation] {
        var alarmArray: [AlarmInformation] = []
        
        dataArray.forEach { data in
            guard let id = data.id,
                  let type = data.type,
                  let location = data.location,
                  let latitude = data.latitude,
                  let longitude = data.longitude,
                  let radius = data.radius,
                  let times = data.times
            else {
                return
            }
            
            let alarm = AlarmInformation(
                id: id,
                type: type,
                latitude: latitude,
                longitude: longitude,
                location: location,
                radius: radius,
                times: times
            )
            
            alarmArray.append(alarm)
        }
        
        return alarmArray
    }
}

// MARK: - CoreDataProcessable

extension ListViewModel: CoreDataProcessable {
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

    func fetchData() -> [AlarmData]? {
        let result = readCoreData()

        switch result {
        case .success(let entity):
            return entity
        case .failure(_):
            return nil
        }
    }
}
