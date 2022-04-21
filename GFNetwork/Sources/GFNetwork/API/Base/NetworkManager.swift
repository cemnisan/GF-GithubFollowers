//
//  File.swift
//  
//
//  Created by Cem Nisan on 21.04.2022.
//

import Foundation

public final class NetworkManager {
    
    public static let shared = NetworkManager()
    
    private init() { }
}

extension NetworkManager {
    
    public func execute<M: Codable,
                        E: HTTPEndpoint>(model: M.Type,
                                     endpoint: E) async -> Result<M>
    {
        guard let request = endpoint.url else { return .failure(.invalidURL) }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else { return .failure(.noResponse) }
            
            switch response.statusCode {
            case 200...299:
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                guard let decodedResponse = try? decoder.decode(model, from: data) else { return .failure(.decode)}
                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}
