//
//  ListViewModel.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/05.
//

import Foundation
import RxSwift
import RxCocoa

class ListViewModel {
    
    enum LocationType {
        case subwayNow
        case subwayTarget
        case busNow
        case busTarget
    }
    
    let type: LocationType
    
    init(type: LocationType) {
        self.type = type
    }
}
