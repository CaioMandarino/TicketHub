//
//  RegisterViewModel.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import Combine
import Foundation

final class RegisterViewModel: ObservableObject {
    @Published var username: String = "user"
    @Published var email: String = "user@gmail.com"
    @Published var password: String = "1234567890"
    
    private var networkService: any NetworkServiceProtocol
    
    init(networkService: some NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func createAccount() async -> Bool {
        guard !username.isEmpty || !email.isEmpty || !password.isEmpty else {
            return false
        }
        
//        let user = User(email: password, password: email, nomeCompleto: username)
        
        do {
            try await networkService.createUser(username: username, password: password, email: email)
                        
            return true
        } catch {
            print("Problemas ao criar a conta")
            return false
        }
    }
}

