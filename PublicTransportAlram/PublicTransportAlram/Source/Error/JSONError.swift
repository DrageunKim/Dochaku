//
//  JSONError.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/01.
//

enum JSONError {
    case decodeAssetError
    case decodeDataError
    
    var errorDescription: String? {
        switch self {
        case .decodeAssetError:
            return "에셋데이터 JSONDecode에러입니다."
        case .decodeDataError:
            return "데이터 JSONDecode에러입니다."
        }
    }
}
