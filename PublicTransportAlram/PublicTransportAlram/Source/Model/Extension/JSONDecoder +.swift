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
                debugPrint(JSONError.decodeAssetError.errorDescription ?? String())
            }
        }
        
        return decodedData
    }
    
    static func decodeData<T: Decodable>(data: Data, to type: T.Type) -> T? {
        var decodedData: T?
        
        do {
            decodedData = try JSONDecoder().decode(type, from: data)
        } catch {
            debugPrint(JSONError.decodeDataError.errorDescription ?? String())
        }
        
        return decodedData
    }
}
