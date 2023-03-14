//
//  StationInfo.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/08.
//

struct StationInfo: Decodable {
    let stations: [Station]
}

struct Station: Decodable {
    let line: String
    let name: String
    let code: Int?
    let lat: Double?
    let lng: Double?
}
