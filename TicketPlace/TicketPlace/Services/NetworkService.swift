//
//  NetworkService.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 06/11/25.
//

import Foundation

actor NetworkService: NetworkServiceProtocol {
    
    private let baseURL = "http://localhost:8000/"

    
    func fetchData<T: Decodable, S: Encodable>(_ type: T.Type, from endpoint: EndpointEnum, method httpMethod: HTTPMethodEnum, body: S?) async throws -> T {
        
        return try await fetchData(type, from: endpoint, method: httpMethod, body: body, decoder: JSONDecoder(), encoding: JSONEncoder())
    }
    
    func fetchData<T: Decodable, S: Encodable>(
        _ type: T.Type,
        from endpoint: EndpointEnum,
        method httpMethod: HTTPMethodEnum,
        body: S?,
        decoder: JSONDecoder,
        encoding: JSONEncoder
    ) async throws -> T {
        
        let url = baseURL + endpoint.rawValue
        var request = URLRequest(url: URL(string: url)!)
    
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try encoding.encode(body)
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }
        
        return try decoder.decode(T.self, from: data)
    }
    
}


