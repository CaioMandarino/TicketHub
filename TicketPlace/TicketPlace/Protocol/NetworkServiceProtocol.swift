//
//  NetworkServiceProtocol.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 06/11/25.
//

import Foundation

protocol NetworkServiceProtocol: Actor {
    func createUser(username: String, password: String, email: String) async throws
    func login(email: String, password: String) async throws
    func getUserInfo() async throws -> UserResponse
    func getEvents() async throws -> [EventsResponse]
    func createEvent(for event: TPEvent) async throws
}
