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
    
    @MainActor
    func createUser(username: String, password: String, email: String) async throws {
        
        let url = baseURL + EndpointEnum.register.rawValue
        var request = URLRequest(url: URL(string: url)!)
    
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        let userData = User(email: email, password: password, name: username)
        let jsonData = try encoder.encode(userData)
        
        request.httpMethod = HTTPMethodEnum.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }
    }
    
    @MainActor
    func login(email: String, password: String) async throws {
        
        let url = baseURL + EndpointEnum.login.rawValue
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = HTTPMethodEnum.post.rawValue
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let formParams: [String: String] = [
            "username": email,
            "password": password,
        ]
        
        request.httpBody = formParams.percentEncoded()
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }
        
        let token = try JSONDecoder().decode(LoginResponse.self, from: data)
        
        try KeychainService.save(token.accessToken, account: "access_token")
    }
}
