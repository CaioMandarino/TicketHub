//
//  LoginViewModel.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var saveCredentials: Bool = false
    
    private let networkService: any NetworkServiceProtocol
    
    init(networkService: some NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func login() async -> Bool {
        guard !email.isEmpty && !password.isEmpty else { return false }
        
        do {
            try await networkService.login(email: email, password: password)
            let _ = try KeychainService.read(account: "access_token")
            
            return true
            
        } catch {
            return false
        }
    }
    
}
