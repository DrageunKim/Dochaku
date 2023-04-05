//
//  AddressSearchListViewModel.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/20.
//

import MapKit

class AddressSearchListViewModel {
    
    // MARK: Internal Properties
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    // MARK: Private Properties
    
    private var places: MKMapItem?
    private var localSearch: MKLocalSearch? {
        willSet {
            places = nil
            localSearch?.cancel()
        }
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
