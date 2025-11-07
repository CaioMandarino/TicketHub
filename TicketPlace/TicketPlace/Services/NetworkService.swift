//
//  NetworkService.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 06/11/25.
//

import Foundation

actor NetworkService: NetworkServiceProtocol {
    
    func fetchData<T: Decodable>(_ type: T.Type, from request: URLRequest) async throws -> T {
        return try await fetchData(T.self, from: request, with: JSONDecoder())
    }
    
    func fetchData<T: Decodable>(_ type: T.Type, from request: URLRequest, with decoder: JSONDecoder) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }
        
        return try decoder.decode(T.self, from: data)
    }
    
}
