//
//  LoginViewModel.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import Combine

final class LoginViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    private let networkService: any NetworkServiceProtocol
    
    init(networkService: some NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func login() {
        guard !username.isEmpty && !password.isEmpty else { return }
    }
    
}
