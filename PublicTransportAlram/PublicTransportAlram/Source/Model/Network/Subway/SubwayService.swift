//
//  RealtimeStationArrival.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/01.
//

import Foundation
import RxSwift

class SubwayService {
    var nowStationCode: Int = 0
    var targetStationCode: Int = 0
    var stationLatitude: Double = 0
    var stationLongitude: Double = 0
    
    var isValidLatitudeAndLongitude = false
    var isValidCode = false
    
    func checkValidLatitudeAndLongitude() {
        isValidLatitudeAndLongitude = stationLatitude != 0 && stationLongitude != 0
    }
    
    func checkValidCode() -> Bool {
        return nowStationCode != 0 && targetStationCode != 0
    }
    
    func fetchStationLatitudeAndLongitude(_ station: String) -> String {
        let codeData = JSONDecoder.decodeAsset(name: "StationInfoJSON", to: StationInfo.self)
        let targetData = codeData?.stations.filter { $0.name == station }
        
        if let data = targetData,
           let latitude = data.first?.lat,
           let longitude = data.first?.lng {
            return "\(latitude) \(longitude)"
        }
        
        return String()
    }
    
    func fetchStationCodeRx() -> Observable<PublicTransitPoiDTO> {
        let manager = NetworkManager(urlSession: .shared)
        let request = PublicTransitPoi(
            type: StationClass.subway,
            latitude: stationLatitude,
            longitude: stationLongitude
        )
        
        return Observable.create { emitter in
            manager.dataTask(request) { result in
                switch result {
                case .success(let data):
                    emitter.onNext(data)
                    emitter.onCompleted()
                case .failure(let error):
                    emitter.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    func fetchSubwayInfoRx() -> Observable<SubwayRouteSearchDTO> {
        let manager = NetworkManager(urlSession: .shared)
        let request = SubwayRouteSearch(
            city: CID.capital,
            now: nowStationCode,
            target: targetStationCode
        )
        
        return Observable.create { emitter in
            manager.dataTask(request) { result in
                switch result {
                case .success(let data):
                    emitter.onNext(data)
                    emitter.onCompleted()
                case .failure(let error):
                    emitter.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
