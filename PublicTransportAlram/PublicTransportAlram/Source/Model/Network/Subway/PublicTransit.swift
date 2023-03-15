//
//  PublicTransit.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/15.
//

import Foundation

struct PublicTransit: Request {
    typealias Response = PublicTransitPOI
    
    let method: HTTPMethod = .get
    var queryList: [String: String] = [:]
    var path: String = "/subwayPath"
    let apiKey: String = "DnMRoATHlXeGpeewYG0b6A"
    let lang: String = String(Lang.korean.rawValue)
    let output: String = "json"
    let radius: String = "250"
    
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

enum StationClass: Int {
    case bus = 0
    case subway
    case train
}

