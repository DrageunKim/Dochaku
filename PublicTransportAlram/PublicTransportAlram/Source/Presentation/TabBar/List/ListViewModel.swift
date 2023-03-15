//
//  ListViewModel.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/05.
//

import Foundation
import RxSwift
import RxCocoa
import MapKit

class ListViewModel {
    
    enum LocationType {
        case subwayNow
        case subwayTarget
        case busNow
        case busTarget
    }
    
    let type: LocationType
    let disposeBag = DisposeBag()

    // MARK: Input
    
    let stationText: AnyObserver<String>
    let fetchSubwayInfo: AnyObserver<Void>
    
    // MARK: Output
    
    let stationName: Observable<[POI]>
    
    init(
        type: LocationType,
        domain: RealTimeStationArrivalService = RealTimeStationArrivalService()
    ) {
        self.type = type
        
        let station = PublishSubject<String>()
        let fetching = PublishSubject<Void>()
        let poi = PublishSubject<PublicTransitPOI>()
        
        stationText = station.asObserver()
        fetchSubwayInfo = fetching.asObserver()
        
        //        fetching
        //            .map(domain.checkValidCode)
        //            .filter { domain.isValidCode }
        //            .flatMap(domain.fetchSubwayInfoRx)
        //            .subscribe(onNext: information.onNext)
        //            .disposed(by: disposeBag)
        
        station
            .filter { $0.count > 0 }
            .map(domain.fetchStationLatitudeAndLongitude)
            .filter { $0.split(separator: " ").count == 2 }
            .subscribe(onNext: { info in
                let data = info.split(separator: " ").compactMap { String($0) }
                
                if let latitude = Double(data[0]),
                   let longitude = Double(data[1]) {
                    print(latitude, longitude)
                    domain.stationLatitude = latitude
                    domain.stationLongitude = longitude
                }
            })
            .disposed(by: disposeBag)
        
        fetching
            .map(domain.checkValidLatitudeAndLongitude)
            .filter { domain.isValidLatitudeAndLongitude }
            .flatMap(domain.fetchSubwayCodeRx)
            .subscribe(onNext: poi.onNext)
            .disposed(by: disposeBag)
        
        stationName = poi
            .map { $0.result.station }
    }
}
