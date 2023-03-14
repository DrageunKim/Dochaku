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

/*
class ListViewModel {
    
    enum LocationType {
        case subwayNow
        case subwayTarget
        case busNow
        case busTarget
    }
    
    let disposeBag = DisposeBag()
    
    let type: LocationType
    let stationInfo: AnyObserver<MKLocalSearchCompletion>
    
    var latitude: Observable<Double>
    //    var longitude: Observable<Double>
    //    var test: Double
    
    private var places: MKMapItem?
    private var localSearch: MKLocalSearch? {
        willSet {
            places = nil
            localSearch?.cancel()
        }
    }
    
    init(type: LocationType) {
        self.type = type
        
        let station = PublishSubject<MKLocalSearchCompletion>()
        
        stationInfo = station.asObserver()
    }
    
    private func searchLocation(for suggestedCompletion: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: suggestedCompletion)
        
        searchRequest.resultTypes = .pointOfInterest
        
        localSearch = MKLocalSearch(request: searchRequest)
        localSearch?.start(completionHandler: { response, error in
            if error != nil {
                return
            }
            
            if let response = response {
                self.places = response.mapItems[0]
                
//                latitude = places?.placemark.coordinate.latitude
                
            }
        })
    }
    
    private func searchLatitude(_ item: MKMapItem) -> Double {
        return item.placemark.coordinate.latitude
    }
}
*/
