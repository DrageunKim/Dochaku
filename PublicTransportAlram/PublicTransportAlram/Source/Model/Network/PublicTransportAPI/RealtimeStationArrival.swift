//
//  RealtimeStationArrival.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/17.
//

import Foundation

struct RealtimeStationArrival: Request {
    var baseURL: URL? {
        return URL(string: "http://swopenAPI.seoul.go.kr/api")
    }
    var queryList: [String : String] = [:]
    
    typealias Response = RealTimeStationArrivalDTO
    
    let method: HTTPMethod = .get
    var path: String = "/subway"
    let apiKey: String = "/DnMRoATHlXeGpeewYG0b6A"
    let type: String = "/json"
    let service: String = "/realtimeStationArrival"
    let startIndex: String = "/0"
    let endIndex: String = "/5"
    
    init(stationName: String) {
        self.path = "/subway" + apiKey + type + service + startIndex + endIndex + "/\(stationName)"
    }
}
