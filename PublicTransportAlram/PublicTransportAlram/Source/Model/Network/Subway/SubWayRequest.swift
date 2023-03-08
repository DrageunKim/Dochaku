//
//  SubWayRequest.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/02/23.
//

import Foundation

struct SubwayRequest: Request {
    typealias Response = SubwayRouteSearch
    
    let method: HTTPMethod = .get
    var queryList: [String: String] = [:]
    var path: String = "/subwayPath"
    let apiKey: String = "DnMRoATHlXeGpeewYG0b6A"
    let lang: String = String(Lang.korean.rawValue)
    let sopt: String = "2"
    
    init(city: CID, start: Int, end: Int) {
        queryList.updateValue(apiKey, forKey: "apiKey")
        queryList.updateValue(lang, forKey: "lang")
        queryList.updateValue(String(city.rawValue), forKey: "CID")
        queryList.updateValue(String(start), forKey: "SID")
        queryList.updateValue(String(end), forKey: "EID")
        queryList.updateValue(sopt, forKey: "Sopt")
    }
}

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
