//
//  Identifiable.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/05.
//

protocol Identifiable {}

extension Identifiable {
    static var identifier: String {
        return String(describing: self)
    }
}
