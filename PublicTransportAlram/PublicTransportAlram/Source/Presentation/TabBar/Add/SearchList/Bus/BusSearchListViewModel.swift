//
//  BusSearchListViewModel.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/20.
//

import MapKit
import RxSwift
import RxCocoa

class BusSearchListViewModel {
    
    // MARK: Internal Properties
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    var latitude: Double = 0
    var longitude: Double = 0
    
    // MARK: Private Properties
    
    private let disposeBag = DisposeBag()
    private var places: MKMapItem?
    private var localSearch: MKLocalSearch? {
        willSet {
            places = nil
            localSearch?.cancel()
        }
    }
    
    // MARK: Input
    
    var xyData: AnyObserver<String>
    
    // MARK: Output
    
    let stationName: Observable<[POI]>
    
    // MARK: Initializer
    
    init(domain: PublicTransportService = PublicTransportService()) {
        let station = PublishSubject<String>()
        let fetching = PublishSubject<Void>()
        let poi = PublishSubject<PublicTransitPoiDTO>()
        
        xyData = station.asObserver()
        
        station
            .filter { $0.count > 0 }
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
            .flatMap(domain.fetchBusPOIRx)
            .subscribe(onNext: poi.onNext)
            .disposed(by: disposeBag)
        
        stationName = poi
            .map { $0.result.station }
    }
    
    // MARK: Internal Methods

    func search(
        for suggestedCompletion: MKLocalSearchCompletion,
        completion: @escaping (CLLocationCoordinate2D
        ) -> Void) {
        let searchRequest = MKLocalSearch.Request(completion: suggestedCompletion)
        
        searchRequest.resultTypes = .address
        
        localSearch = MKLocalSearch(request: searchRequest)
        localSearch?.start(completionHandler: { response, error in
            if error != nil {
                return
            }
            
            self.places = response?.mapItems[0]
            
            if let places = self.places {
                return completion(places.placemark.coordinate)
            }
        })
    }
}
