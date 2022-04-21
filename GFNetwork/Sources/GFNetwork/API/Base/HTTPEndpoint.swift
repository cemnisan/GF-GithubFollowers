//
//  File.swift
//  
//
//  Created by Cem Nisan on 21.04.2022.
//

import Foundation

public protocol HTTPEndpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var url: URLRequest? { get }
}

extension HTTPEndpoint {
    var baseURL: String {
        return "https://api.github.com"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var header: [String: String]? {
        return nil
    }
    
    var body: [String: String]? {
        return nil
    }
    
    var url: URLRequest? {
        guard let url = URL(string: baseURL + path) else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = header
        
        if let body = body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        return urlRequest
    }
}
