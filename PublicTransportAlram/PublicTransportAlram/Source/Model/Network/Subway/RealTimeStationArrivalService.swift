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
    
    private let disposeBag = DisposeBag()
    
    func checkValidCode() {
        isValidCode = !nowStationCode.isEmpty && !targetStationCode.isEmpty
    }
    
    func fetchStationCode(_ station: String) -> String {
        let codeData = JSONDecoder.decodeAsset(name: "StationCodeJSON", to: StationCodeInfo.self)
        let targetData = codeData?.data.filter { $0.stationNm == station }
        
        if let data = targetData,
           let subwayCode = data.first?.stationCd {
            return subwayCode
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
