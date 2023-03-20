//
//  PublicTransitPoiDTO.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/15.
//

struct PublicTransitPoiDTO: Decodable {
    let result: PublicTransitResult
}

struct PublicTransitResult: Decodable {
    let count: Int
    let station: [POI]
}

struct POI: Decodable {
    let nonstopStation: Int
    let stationClass: Int
    let stationName: String
    let stationID: Int
    let x: Double
    let y: Double
    let arsID: String
    let type: Int?
    let laneName: String?
    let laneCity: String?
    let ebid: String
}
