//
//  SubwaySearchListViewModel.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/20.
//

import RxSwift
import RxCocoa

class SubwaySearchListViewModel {
    
    // MARK: Private Properties
    
    private let disposeBag = DisposeBag()

    // MARK: Input
    
    let stationText: AnyObserver<String>
    
    // MARK: Output
    
    let stationName: Observable<[POI]>
    
    // MARK: Initializer
    
    init(domain: PublicTransportService = PublicTransportService()) {
        let station = PublishSubject<String>()
        let fetching = PublishSubject<Void>()
        let poi = PublishSubject<PublicTransitPoiDTO>()
        
        stationText = station.asObserver()
        
        station
            .filter { $0.count > 0 }
            .map(domain.checkWord)
            .map(domain.fetchStationLatitudeAndLongitude)
            .filter { $0.split(separator: " ").count == 2 }
            .map {
                let data = $0.split(separator: " ").compactMap { String($0) }
                
                if let latitude = Double(data[0]),
                   let longitude = Double(data[1]) {
                    domain.stationLatitude = latitude
                    domain.stationLongitude = longitude
                }
            }
            .subscribe(onNext: fetching.onNext)
            .disposed(by: disposeBag)
        
        fetching
            .map(domain.checkValidLatitudeAndLongitude)
            .filter { domain.isValidLatitudeAndLongitude }
            .flatMap(domain.fetchSubwayPOIRx)
            .subscribe(onNext: poi.onNext)
            .disposed(by: disposeBag)
        
        stationName = poi
            .map { $0.result.station }
    }
}
