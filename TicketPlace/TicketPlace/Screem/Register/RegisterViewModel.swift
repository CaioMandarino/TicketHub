//
//  RegisterViewModel.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import Combine
import Foundation

final class RegisterViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    private var networkService: any NetworkServiceProtocol
    
    init(networkService: some NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func createAccount() async -> Bool {
        guard !username.isEmpty || !email.isEmpty || !password.isEmpty else {
            return false
        }
                
        do {
            try await networkService.createUser(username: username, password: password, email: email)
            try await login()
            return true
        } catch {
            print("Problemas ao criar a conta")
            return false
        }
    }
    
    
    func login() async throws {
        try await networkService.login(email: email, password: password)
    }
}

