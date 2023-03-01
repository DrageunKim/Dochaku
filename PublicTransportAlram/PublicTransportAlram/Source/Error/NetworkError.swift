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
    
    var errorDescription: String? {
        switch self {
        case .informationError:
            return "Network: 조건부 에러입니다."
        case .redirectionError:
            return "Network: 리다이렉션 에러입니다."
        case .clientError:
            return "Network: 요청 에러입니다."
        case .serverError:
            return "Network: 서버 에러입니다."
        case .unknownError:
            return "Network: 알 수 없는 에러입니다."
        case .invalidDataError:
            return "Network: 유효하지 않은 데이터입니다."
        case .dataTaskError:
            return "Network: dataTask 실행에러입니다."
        }
    }
}
