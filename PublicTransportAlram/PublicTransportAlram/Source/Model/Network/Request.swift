//
//  Request.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/02/23.
//

import Foundation

protocol Request {
    associatedtype Response: Decodable
    
    var baseURL: URL? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryList: [String: String] { get }
}

extension Request {
    var url: URL? {
        if let url = baseURL?.appendingPathComponent(path) {
            var components = URLComponents(string: url.absoluteString)
            let queries: [URLQueryItem] = queryList.map { key, value -> URLQueryItem in
                return URLQueryItem(name: key, value: value)
            }
            
            components?.queryItems = queries
            
            return components?.url
        }
        
        return nil
    }
    
    func create() -> URLRequest {
        if let url = url {
            var urlRequest = URLRequest(url: url)
            
            urlRequest.httpMethod = method.rawValue
            
            return urlRequest
        }
        
        return URLRequest(url: URL(fileURLWithPath: String()))
    }
}
