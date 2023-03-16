//
//  SubwayRouteSearch.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/02/23.
//

import Foundation

struct SubwayRouteSearch: Request {
    var baseURL: URL? {
        return URL(string: "https://api.odsay.com/v1/api")
    }
    
    typealias Response = SubwayRouteSearchDTO
    
    let method: HTTPMethod = .get
    var queryList: [String: String] = [:]
    var path: String = "/subwayPath"
    let apiKey: String = "DnMRoATHlXeGpeewYG0b6A"
    let lang: String = String(Lang.korean.rawValue)
    let sopt: String = "2"
    
    init(city: CID, now: Int, target: Int) {
        queryList.updateValue(apiKey, forKey: "apiKey")
        queryList.updateValue(lang, forKey: "lang")
        queryList.updateValue(String(city.rawValue), forKey: "CID")
        queryList.updateValue(String(now), forKey: "SID")
        queryList.updateValue(String(target), forKey: "EID")
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
