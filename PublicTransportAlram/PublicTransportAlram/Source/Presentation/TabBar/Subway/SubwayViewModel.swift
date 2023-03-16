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
    var arrivalTime: String = .init()
    var nowStationCode: Int = .init()
    var targetStationCode: Int = .init()
    
    // MARK: Input
    
    let fetchSubwayInfo: AnyObserver<Void>
    
    // MARK: Output
    
    let subwayInfo: Observable<SubwayRouteSearchDTO>
    
    init(domain: SubwayService = SubwayService()) {
        let fetching = PublishSubject<Void>()
        let information = PublishSubject<SubwayRouteSearchDTO>()
        
        fetchSubwayInfo = fetching.asObserver()
        subwayInfo = information.asObserver()
        
        fetching
            .map {
                domain.nowStationCode = self.nowStationCode
                domain.targetStationCode = self.targetStationCode
            }
            .filter { domain.checkValidCode() }
            .flatMap(domain.fetchSubwayInfoRx)
            .subscribe(onNext: information.onNext)
            .disposed(by: disposeBag)
    }
}
