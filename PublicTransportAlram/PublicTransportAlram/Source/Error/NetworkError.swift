//
//  NetworkError.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/01.
//

enum NetworkError: Error {
    case informationError
    case redirectionError
    case clientError
    case serverError
    case unknownError
    case invalidDataError
    case dataTaskError
    case parsingError
    
    var errorDescription: String? {
        switch self {
        case .informationError:
            return "조건부 에러입니다."
        case .redirectionError:
            return "리다이렉션 에러입니다."
        case .clientError:
            return "요청 에러입니다."
        case .serverError:
            return "서버 에러입니다."
        case .unknownError:
            return "알 수 없는 에러입니다."
        case .invalidDataError:
            return "유효하지 않은 데이터입니다."
        case .dataTaskError:
            return "dataTask 실행에러입니다."
        case .parsingError:
            return "JSON 파싱에러입니다."
        }
    }
}
