//
//  NetworkServiceProtocol.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 06/11/25.
//

import Foundation

protocol NetworkServiceProtocol: Actor {
//    func fetchData<T: Decodable, S: Encodable>(
//        _ type: T.Type,
//        from endpoint: EndpointEnum,
//        method httpMethod: HTTPMethodEnum,
//        body: S?
//    ) async throws -> T
//    
//    func fetchData<T: Decodable, S: Encodable>(
//        _ type: T.Type,
//        from endpoint: EndpointEnum,
//        method httpMethod: HTTPMethodEnum,
//        body: S?,
//        decoder: JSONDecoder,
//        encoding: JSONEncoder
//    ) async throws -> T
//    
    
    func createUser(username: String, password: String, email: String) async throws
    func login(email: String, password: String) async throws
}
