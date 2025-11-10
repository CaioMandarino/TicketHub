//
//  LoginViewModel.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import Combine
import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var saveCredentials: Bool = false
    @Published var alertMessage: String? = nil
    
    var isFormValid: Bool { !email.isEmpty && !password.isEmpty }
    private let networkService: any NetworkServiceProtocol
    
    init(networkService: some NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func login() async -> Bool {
        guard isFormValid else { return false }
        
        do {
            try await networkService.login(email: email, password: password)
            let _ = try KeychainService.read(account: KeychainKeysEnum.accessToken)
            
            return true
            
        } catch URLError.userAuthenticationRequired {
            alertMessage = "Sua senha ou email estão incorretos"
        } catch {
            alertMessage = "Ocorreu um problema, tente novamente mais tarde"
        }
        return false

    }
    
}
