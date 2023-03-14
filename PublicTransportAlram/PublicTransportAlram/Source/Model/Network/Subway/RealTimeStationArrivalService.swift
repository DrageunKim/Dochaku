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
    var targetStationCode = String()
    var isValidCode = false
    
    func checkValidCode() {
        isValidCode = !nowStationCode.isEmpty && !targetStationCode.isEmpty
    }
    
    func fetchStationCode(_ station: String) -> String {
        let codeData = JSONDecoder.decodeAsset(name: "StationInfoJSON", to: StationInfo.self)
        let targetData = codeData?.stations.filter { $0.name == station }
        
        if let data = targetData,
           let subwayCode = data.first?.code {
            return String(subwayCode)
        }
        
        return String()
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
