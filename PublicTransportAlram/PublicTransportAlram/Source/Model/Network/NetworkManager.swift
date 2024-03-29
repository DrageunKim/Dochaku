//
//  NetworkManager.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/02/23.
//

import Foundation

struct NetworkManager {
    
    // MARK: Private Properties
    
    private let urlSession: URLSession

    // MARK: Initializer
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    // MARK: Internal MEthods

    func dataTask<R: Request>(_ request: R, completion: @escaping (Result<R.Response, NetworkError>) -> Void) {
        let urlRequest = request.create()
        
        urlSession.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
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
            
            if let data = decodedData {
                return completion(.success(data))
            }
            
            return completion(.failure(.unknownError))
        }.resume()
    }
}
