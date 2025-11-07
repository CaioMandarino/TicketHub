//
//  NetworkServiceProtocol.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 06/11/25.
//

import Foundation

protocol NetworkServiceProtocol: Actor {
    func fetchData<T: Decodable>(_ type: T.Type, from request: URLRequest) async throws -> T
    
    func fetchData<T: Decodable>(_ type: T.Type, from request: URLRequest, with decoder: JSONDecoder) async throws -> T

}
