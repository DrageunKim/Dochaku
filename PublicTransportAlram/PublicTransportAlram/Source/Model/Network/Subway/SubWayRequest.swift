//
//  SubWayRequest.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/02/23.
//


struct SubwayRequest: Request {
    typealias Response = [Subway]
    
    let key: String = "74795961676b696f3130334a514c4f75"
    let type: String = "json"
    var path: String
    var method: HTTPMethod = .get
    
    init(station: String) {
        self.path = "subway/\(key)/\(type)/realtimeStationArrival/0/5/\(station)"
    }
}
