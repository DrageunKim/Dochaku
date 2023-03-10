//
//  SubwayCodeInfo.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/08.
//

struct StationCodeInfo: Decodable {
    let data: [DataInfo]
    
    enum CodingKeys: String, CodingKey {
        case data = "DATA"
    }
}

struct DataInfo: Decodable {
    let lineNum: String
    let stationCd: String
    let stationNm: String
    let frCode: String
    
    enum CodingKeys: String, CodingKey {
        case lineNum = "line_num"
        case stationCd = "station_cd"
        case stationNm = "station_nm"
        case frCode = "fr_code"
    }
}
