//
//  PublicTransitPoi.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/15.
//

import Foundation

struct PublicTransitPoi: Request {
    var baseURL: URL? {
        return URL(string: "https://api.odsay.com/v1/api")
    }
    var queryList: [String: String] = [:]
    
    typealias Response = PublicTransitPoiDTO
    
    let method: HTTPMethod = .get
    var path: String = "/pointSearch"
    let apiKey: String = "DnMRoATHlXeGpeewYG0b6A"
    let lang: String = String(Lang.korean.rawValue)
    let output: String = "json"
    let radius: String = "500"
    
    init(type: StationClass, latitude: Double, longitude: Double) {
        queryList.updateValue(apiKey, forKey: "apiKey")
        queryList.updateValue(lang, forKey: "lang")
        queryList.updateValue(output, forKey: "output")
        queryList.updateValue(String(longitude), forKey: "x")
        queryList.updateValue(String(latitude), forKey: "y")
        queryList.updateValue(radius, forKey: "radius")
        queryList.updateValue(String(type.rawValue), forKey: "StationClass")
    }
}
