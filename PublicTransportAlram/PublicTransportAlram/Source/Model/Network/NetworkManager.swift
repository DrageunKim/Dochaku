//
//  NetworkManager.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/02/23.
//

import Foundation

struct NetworkManager {
    private let urlSession: URLSession

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    func dataTask<R: Request>(_ request: R, completion: @escaping (Result<R.Response, NetworkError>) -> Void) {
        let urlRequest = request.create()
        urlSession.dataTask(with: urlRequest) { data, response, error in
            if let _ = error {
                completion(.failure(.dataTaskError))
            }
            
            if let serverResponse = response as? HTTPURLResponse {
                switch serverResponse.statusCode {
                case 100...101:
                    return completion(.failure(.informationError))
                case 200...206:
                    break
                case 300...307:
                    return completion(.failure(.redirectionError))
                case 400...415:
                    return completion(.failure(.clientError))
                case 500...505:
                    return completion(.failure(.serverError))
                default:
                    return completion(.failure(.unknownError))
                }
            }
            
            guard let wrappedData = data else { return completion(.failure(.invalidDataError)) }
            let decodedData = JSONDecoder.decodeData(data: wrappedData, to: R.Response.self)
            guard let data = decodedData else { return completion(.failure(.parsingError)) }
            
            return completion(.success(data))
        }
        .resume()
    }
}
