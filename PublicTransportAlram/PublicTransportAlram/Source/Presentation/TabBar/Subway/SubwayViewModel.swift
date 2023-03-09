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
        let fetching = PublishSubject<Void>()
        let information = PublishSubject<SubwayRouteSearch>()
        
        let nowStation = PublishSubject<String>()
        let targetStation = PublishSubject<String>()
        
        fetchSubwayInfo = fetching.asObserver()
        subwayInfo = information.asObserver()
        nowStationText = nowStation.asObserver()
        targetStationText = targetStation.asObserver()
        
        fetching
            .flatMap(domain.fetchSubwayInfoRx)
            .subscribe(onNext: information.onNext)
            .disposed(by: disposeBag)
        
        nowStation
            .map(domain.fetchSubwayCode)
            .subscribe(onNext: { code in
                domain.nowStationCode = code
            })
            .disposed(by: disposeBag)
        
        targetStation
            .map(domain.fetchSubwayCode)
            .subscribe(onNext: { code in
                domain.targetStationCode = code
            })
            .disposed(by: disposeBag)
    }
}
