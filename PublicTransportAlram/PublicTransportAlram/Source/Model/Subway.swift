//
//  Subway.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/02/23.
//

struct Subway: Decodable {
    let errorMessage: [errorMessage]
    let realtimeArrivalList: [realtimeArrivalList]
}

struct errorMessage: Decodable {
    let state: Int
    let code: String
    let message: String
    let link: String
    let developerMessage: String
    let total: Int
}

struct realtimeArrivalList: Decodable {
    let beginRow: Int
    let endRow: Int
    let curPage: Int
    let pageRow: Int
    let totalCount: Int
    let rowNum: Int
    let selectedCount: Int
    let subwayId: String
    let subwayNm: Int
    let updnLine: String
    let trainLineNm: String
    let subwayHeading: String
    let statnFid: String
    let statnTid: String
    let statnId: String
    let statnNm: String
    let trainCo: Int
    let ordkey: String
    let subwayList: String
    let statnList: String
    let btrainSttus: Int
    let barvlDt: String
    let btrainNo: String
    let bstatnId: String
    let bstatnNm: String
    let recptnDt: String
    let arvlMsg2: String
    let arvlMsg3: String
    let arvlCd: String
}
