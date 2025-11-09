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
        
        let url = baseURL + EndpointEnum.register.path
        var request = URLRequest(url: URL(string: url)!)
    
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        let userData = UserData(email: email, password: password, name: username)
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
        
        let url = baseURL + EndpointEnum.login.path
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
            if httpResponse.statusCode == 401 {
                throw URLError(.userAuthenticationRequired)
            } else {
                throw URLError(.badServerResponse)
            }
        }
        
        let token = try JSONDecoder().decode(LoginResponse.self, from: data)
        
        
        try KeychainService.save(token.accessToken, account: KeychainKeysEnum.accessToken)
    }
    
    @MainActor
    func getUserInfo() async throws -> UserResponse {
        try await get(UserResponse.self, for: .userInfo)
    }

    @MainActor
    func getEvents() async throws -> [EventsResponse] {
        try await get(Array<EventsResponse>.self, for: .events)
    }
    
    @MainActor
    private func get<T: Decodable>(_ type: T.Type, for endpoint: EndpointEnum) async throws -> T {
        guard let url = URL(string: baseURL + endpoint.path) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        
        guard let token = try? KeychainService.read(account: KeychainKeysEnum.accessToken) else {
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
        
        let decoder = JSONDecoder()

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        decoder.dateDecodingStrategy = .formatted(formatter)
        
        let element = try decoder.decode(type, from: data)
        
        return element
    }
    
    @MainActor
    func createEvent(for event: TPEvent) async throws {
        let url = baseURL + EndpointEnum.newEvent.path
        var request = URLRequest(url: URL(string: url)!)
    
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601
        
        let eventData = try event.convertToEventData()
        let jsonData = try encoder.encode(eventData)
        
        guard let token = try? KeychainService.read(account: KeychainKeysEnum.accessToken) else {
            throw URLError(.userAuthenticationRequired)
        }
        
        request.httpMethod = HTTPMethodEnum.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }
    }
    
    
    @MainActor
    func updateEvent(for event: TPEvent) async throws {
        let url = baseURL + EndpointEnum.updateEvent(id: event.id).path
        var request = URLRequest(url: URL(string: url)!)
    
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601
        
        let eventData = try event.convertToEventData()
        let jsonData = try encoder.encode(eventData)
        
        guard let token = try? KeychainService.read(account: KeychainKeysEnum.accessToken) else {
            throw URLError(.userAuthenticationRequired)
        }
        
        request.httpMethod = HTTPMethodEnum.put.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }
    }
    
    @MainActor
    func deleteEvent(id: String) async throws {
        let url = baseURL + EndpointEnum.deleteEvent(id: id).path
        var request = URLRequest(url: URL(string: url)!)
        
        guard let token = try? KeychainService.read(account: KeychainKeysEnum.accessToken) else {
            throw URLError(.userAuthenticationRequired)
        }
        
        request.httpMethod = HTTPMethodEnum.delete.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }
    }
    
    @MainActor
    func updateUsername(new username: String) async throws {
        let url = baseURL + EndpointEnum.newUsername.path
        var request = URLRequest(url: URL(string: url)!)
        
        guard let token = try? KeychainService.read(account: KeychainKeysEnum.accessToken) else {
            throw URLError(.userAuthenticationRequired)
        }
        
        let jsonData = try JSONEncoder().encode(Username(username: username))
        
        request.httpMethod = HTTPMethodEnum.put.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let (_, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }
    }
    
    @MainActor
    func updatePassword(old oldPassword: String, new newPassword: String) async throws {
        let url = baseURL + EndpointEnum.newPassword.path
        var request = URLRequest(url: URL(string: url)!)
        
        guard let token = try? KeychainService.read(account: KeychainKeysEnum.accessToken) else {
            throw URLError(.userAuthenticationRequired)
        }
        
        let jsonData = try JSONEncoder().encode(Password(oldPassword: oldPassword, newPassword: newPassword))
        
        request.httpMethod = HTTPMethodEnum.put.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let (_, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }
    }
    
    @MainActor
    func getAllUsers(term: String) async throws -> [UserResponse] {
        
        guard var components = URLComponents(string: baseURL + EndpointEnum.getUsers.path) else {
            throw URLError(.badURL)
        }
        
        components.queryItems = [
            URLQueryItem(name: "q", value: term)
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        
        guard let token = try? KeychainService.read(account: KeychainKeysEnum.accessToken) else {
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
        
        let users = try JSONDecoder().decode(Array<UserResponse>.self, from: data)
        
        return users
    }
}

extension NetworkService {
    struct Username: Encodable {
        let username: String
        
        enum CodingKeys: String, CodingKey {
            case username = "nome_completo"
        }
    }
    
    struct Password: Encodable {
        let oldPassword: String
        let newPassword: String
        
        enum CodingKeys: String, CodingKey {
            case oldPassword = "old_password"
            case newPassword = "new_password"
        }
    }
}
