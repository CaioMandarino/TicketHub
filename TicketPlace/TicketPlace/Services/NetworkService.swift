//
//  NetworkService.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 06/11/25.
//

import Foundation

actor NetworkService: NetworkServiceProtocol {
    
    private let baseURL = "http://localhost:8000/"
    
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
        
        try KeychainService.save(token.accessToken, account: KeychainKeysEnum.accessToken)
    }
    
    @MainActor
    func getUserInfo() async throws -> UserResponse {
        try await get(UserResponse.self, for: .userInfo)
    }
    
    func getEvents() async throws -> [EventsResponse] {
        try await get(Array<EventsResponse>.self, for: .events)
    }
    
    private func get<T: Decodable>(_ type: T.Type, for endpoint: EndpointEnum) async throws -> T {
        guard let url = URL(string: baseURL + endpoint.rawValue) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        
        guard let token = try? await KeychainService.read(account: KeychainKeysEnum.accessToken) else {
            throw URLError(.userAuthenticationRequired)
        }
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            if httpResponse.statusCode == 401 {
                throw URLError(.userAuthenticationRequired)
            } else {
                throw URLError(.badServerResponse)
            }
        }
        
        let element = try JSONDecoder().decode(type, from: data)
        
        return element
    }
}
