//
//  RegisterViewModel.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import Combine

final class RegisterViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    private var networkService: any NetworkServiceProtocol
    
    init(networkService: some NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func createAccount() -> Bool {
        guard !username.isEmpty || !email.isEmpty || !password.isEmpty else {
            return false
        }
        
        return true
    }
}
