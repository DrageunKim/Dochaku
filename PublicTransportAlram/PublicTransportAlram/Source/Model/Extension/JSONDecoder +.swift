//
//  JSONDecoder +.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/02/23.
//

import UIKit

extension JSONDecoder {
    static func decodeAsset<T: Decodable>(name: String, to type: T.Type) -> T? {
        var decodedData: T?
        
        if let dataAsset = NSDataAsset(name: name)?.data {
            do {
                decodedData = try JSONDecoder().decode(type, from: dataAsset)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return decodedData
    }
}
