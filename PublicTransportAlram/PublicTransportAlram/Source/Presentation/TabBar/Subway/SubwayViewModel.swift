//
//  SubwayViewModel.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/02/23.
//

import Foundation
import RxSwift
import RxCocoa

class SubwayViewModel {
    
    let disposeBag = DisposeBag()
    let arrivalTime: String = .init()
    
    // MARK: Input
    
    let nowStationText: AnyObserver<String>
    let targetStationText: AnyObserver<String>
    let fetchSubwayInfo: AnyObserver<Void>
    
    // MARK: Output
    
    let subwayInfo: Observable<SubwayRouteSearch>
    
    init(domain: RealTimeStationArrivalService = RealTimeStationArrivalService()) {
        let nowStation = PublishSubject<String>()
        let targetStation = PublishSubject<String>()
        let fetching = PublishSubject<Void>()
        
        let information = PublishSubject<SubwayRouteSearch>()
        
        nowStationText = nowStation.asObserver()
        targetStationText = targetStation.asObserver()
        fetchSubwayInfo = fetching.asObserver()
        
        subwayInfo = information.asObserver()
        
        fetching
            .map(domain.checkValidCode)
            .filter { domain.isValidCode }
            .flatMap(domain.fetchSubwayInfoRx)
            .subscribe(onNext: information.onNext)
            .disposed(by: disposeBag)
        
        nowStation
            .filter { $0.count > 0 }
            .map(domain.fetchStationLatitudeAndLogitude)
            .filter { $0.split(separator: " ").count == 2 }
            .subscribe(onNext: { info in
                let data = info.split(separator: " ").compactMap { String($0) }
                
                if let latitude = Double(data[0]),
                   let longitude = Double(data[1]) {
                    domain.nowStationLatitude = latitude
                    domain.nowStationLongitude = longitude
                    print(latitude, longitude)
                }
            })
            .disposed(by: disposeBag)
        
        targetStation
            .filter { $0.count > 0 }
            .map(domain.fetchStationLatitudeAndLogitude)
            .filter { $0.split(separator: " ").count == 2 }
            .subscribe(onNext: { info in
                let data = info.split(separator: " ").compactMap { String($0) }
                
                if let latitude = Double(data[0]),
                   let longitude = Double(data[1]) {
                    domain.targetStationLatitude = latitude
                    domain.targetStationLongitude = longitude
                }
            })
            .disposed(by: disposeBag)
    }
}
