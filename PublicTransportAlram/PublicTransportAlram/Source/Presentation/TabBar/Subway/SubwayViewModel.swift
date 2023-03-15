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
    
    let stationText: AnyObserver<String>
    let fetchSubwayInfo: AnyObserver<Void>
    
    // MARK: Output
    
    let subwayInfo: Observable<SubwayRouteSearch>
    
    init(domain: RealTimeStationArrivalService = RealTimeStationArrivalService()) {
        let station = PublishSubject<String>()
        let fetching = PublishSubject<Void>()
        
        let information = PublishSubject<SubwayRouteSearch>()
        
        stationText = station.asObserver()
        fetchSubwayInfo = fetching.asObserver()
        
        subwayInfo = information.asObserver()
        
//        fetching
//            .map(domain.checkValidCode)
//            .filter { domain.isValidCode }
//            .flatMap(domain.fetchSubwayInfoRx)
//            .subscribe(onNext: information.onNext)
//            .disposed(by: disposeBag)
        
        fetching
            .map(domain.checkValidLatitudeAndLongitude)
            .filter { domain.isValidLatitudeAndLongitude }
            .flatMap(domain.fetchSubwayCodeRx)
            .subscribe(onNext: { data in
                print(data)
            })
            .disposed(by: disposeBag)
        
        station
            .filter { $0.count > 0 }
            .map(domain.fetchStationLatitudeAndLongitude)
            .filter { $0.split(separator: " ").count == 2 }
            .subscribe(onNext: { info in
                let data = info.split(separator: " ").compactMap { String($0) }
                
                if let latitude = Double(data[0]),
                   let longitude = Double(data[1]) {
                    domain.stationLatitude = latitude
                    domain.stationLongitude = longitude
                    print(latitude, longitude)
                }
            })
            .disposed(by: disposeBag)
    }
}
