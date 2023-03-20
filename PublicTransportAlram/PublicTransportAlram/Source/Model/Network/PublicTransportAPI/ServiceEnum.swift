//
//  ServiceEnum.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/17.
//

enum Lang: Int {
    case korean = 0
    case english
    case japanese
    case chinese_simplified
    case chinese_traditional
    case vietnamese
}

enum CID: Int {
    case capital = 1000
    case daejeon = 3000
    case daegu = 4000
    case gwangju = 5000
    case busan = 7000
}

enum StationClass: Int {
    case bus = 1
    case subway
    case train
}

