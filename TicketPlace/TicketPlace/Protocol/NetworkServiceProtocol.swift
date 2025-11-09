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
    func updateEvent(for event: TPEvent) async throws
    func deleteEvent(id: String) async throws
    func updateUsername(new username: String) async throws
    func updatePassword(old oldPassword: String, new newPassword: String) async throws
    func getAllUsers(term: String) async throws -> [UserResponse]
}
