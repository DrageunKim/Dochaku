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
    var queryList: [String: String] = [:]
    
    typealias Response = SubwayRouteSearchDTO
    
    let method: HTTPMethod = .get
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

