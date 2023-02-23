//
//  SubWayRequest.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/02/23.
//


struct SubwayRequest: Request {
    typealias Response = [Subway]
    
    init(station: String) {
        self.path = "subway/74795961676b696f3130334a514c4f75/json/realtimeStationArrival/0/5/\(station)"
    }
    
    var path: String
    var method: HTTPMethod = .get
}
