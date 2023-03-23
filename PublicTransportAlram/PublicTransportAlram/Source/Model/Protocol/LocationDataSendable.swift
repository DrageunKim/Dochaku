//
//  Sendable.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/20.
//

protocol LocationDataSendable {
    func locationDataSend(longitude: Double, latitude: Double, location: String, lane: String)
}
