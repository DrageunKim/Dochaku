//
//  SubwayViewModel.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/02/23.
//

import Foundation
import RxSwift
import RxCocoa

class SubwayViewModel {
    
    let disposeBag = DisposeBag()
    let arrivalTime: String = .init()
    
    // MARK: Input
    
    let nowStationText: AnyObserver<String>
    let targetStationText: AnyObserver<String>
    let fetchSubwayInfo: AnyObserver<Void>
    
    // MARK: Output
    
    let subwayInfo: Observable<SubwayRouteSearch>
    
    init(domain: RealTimeStationArrivalService = RealTimeStationArrivalService()) {
        let nowStation = PublishSubject<String>()
        let targetStation = PublishSubject<String>()
        let fetching = PublishSubject<Void>()
        
        let information = PublishSubject<SubwayRouteSearch>()
        
        nowStationText = nowStation.asObserver()
        targetStationText = targetStation.asObserver()
        fetchSubwayInfo = fetching.asObserver()
        
        subwayInfo = information.asObserver()
        
        fetching
            .map(domain.checkValidCode)
            .filter { domain.isValidCode }
            .flatMap(domain.fetchSubwayInfoRx)
            .subscribe(onNext: information.onNext)
            .disposed(by: disposeBag)
        
        nowStation
            .filter { $0.count > 0 }
            .map(domain.fetchStationCode)
            .subscribe(onNext: { code in
                print(code)
                domain.nowStationCode = code
            })
            .disposed(by: disposeBag)
        
        targetStation
            .filter { $0.count > 0 }
            .map(domain.fetchStationCode)
            .subscribe(onNext: { code in
                print(code)
                domain.targetStationCode = code
            })
            .disposed(by: disposeBag)
    }
}
