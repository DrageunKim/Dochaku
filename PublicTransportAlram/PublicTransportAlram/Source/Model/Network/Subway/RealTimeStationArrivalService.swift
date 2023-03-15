//
//  RealtimeStationArrival.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/01.
//

import Foundation
import RxSwift

class RealTimeStationArrivalService {
    
    var nowStationCode = String()
    var nowStationLatitude: Double = 0
    var nowStationLongitude: Double = 0
    
    var targetStationCode = String()
    var targetStationLatitude: Double = 0
    var targetStationLongitude: Double = 0
    
    var isValidCode = false
    
    func checkValidCode() {
        isValidCode = !nowStationCode.isEmpty && !targetStationCode.isEmpty
    }
    
    func fetchStationLatitudeAndLogitude(_ station: String) -> String {
        let codeData = JSONDecoder.decodeAsset(name: "StationInfoJSON", to: StationInfo.self)
        let targetData = codeData?.stations.filter { $0.name == station }
        
        if let data = targetData,
           let latitude = data.first?.lat,
           let longitude = data.first?.lng {
            return "\(latitude) \(longitude)"
        }
        
        return String()
    }
    
    func fetchSubwayCodeRx() -> Observable<SubwayRouteSearch> {
        let manager = NetworkManager(urlSession: .shared)
        let request = SubwayRequest(city: CID.capital, now: nowStationCode, target: targetStationCode)
        
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
    
    func fetchSubwayInfoRx() -> Observable<SubwayRouteSearch> {
        let manager = NetworkManager(urlSession: .shared)
        let request = SubwayRequest(city: CID.capital, now: nowStationCode, target: targetStationCode)
        
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
