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
    let globalDistance: Double
    let globalStationCount: Int
    let fare: Int
    let cashFare: Int
    let driveInfoSet: DriveInfoSet?
    let exChangeInfoSet: ExChangeInfoSet?
    let stationSet: StationSet?
}

struct DriveInfoSet: Decodable {
    let driveInfo: [DriveInfo]
}

struct ExChangeInfoSet: Decodable {
    let exChangeInfo: [ExChangeInfo]
}

struct StationSet: Decodable {
    let stations: [Stations]
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
