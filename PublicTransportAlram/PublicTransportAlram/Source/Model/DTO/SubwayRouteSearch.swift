//
//  SubwayRouteSearch.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/02/23.
//

struct SubwayRouteSearch: Decodable {
    let result: SearchResult
}

struct SearchResult: Decodable {
    let globalStartName: String
    let globalEndName: String
    let globalTravelTime: Int
    let globalDistance: Int
    let globalStationCount: Int
    let fare: Int
    let cashFare: Int
    let driveInfoSet: [DriveInfo]
    let exChangeInfoSet: [ExChangeInfo]
    let stationSet: [Stations]
}

struct DriveInfo: Decodable {
    let laneID: String
    let laneName: String
    let startName: String
    let stationCount: Int
    let wayCode: Int
    let wayName: String
}

struct ExChangeInfo: Decodable {
    let laneName: String
    let startName: String
    let exName: String
    let exSID: Int
    let fastTrain: Int
    let fastDoor: Int
    let exWalkTime: Int
}

struct Stations: Decodable {
    let startID: Int
    let startName: String
    let endSID: Int
    let endName: String
    let travelTime: Int
}
