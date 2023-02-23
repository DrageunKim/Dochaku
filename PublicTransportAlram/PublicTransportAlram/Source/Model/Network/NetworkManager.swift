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

    func dataTask<R: Request>(_ request: R, completion: @escaping (Result<R.Response, RequestError>) -> Void) {
        let urlRequest = request.create()
        urlSession.dataTask(with: urlRequest) { data, response, error in
            // 처리

            // 성공
            if let wrappedData = data {
                let response = try! JSONDecoder().decode(R.Response.self, from: wrappedData)
                completion(.success(response))
            }
        }
        .resume()
    }
}
