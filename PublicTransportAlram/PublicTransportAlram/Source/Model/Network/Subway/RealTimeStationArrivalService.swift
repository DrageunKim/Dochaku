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
    
    private let disposeBag = DisposeBag()
    
    func fetchSubwayCode(_ station: String) -> String {
        let codeData = JSONDecoder.decodeAsset(name: "SubwayCodeJSON", to: SubwayCodeInfo.self)
        let targetData = codeData?.data.filter { $0.stationNm == station }
        
        if let data = targetData,
           let subwayCode = data.first?.stationCd {
            return subwayCode
        }
        
        return String()
    }
    
    func fetchSubwayInfoRx() -> Observable<SubwayRouteSearch> {
        print("nowCode: \(nowStationCode), target: \(targetStationCode)")
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
