//
//  CreateEventViewModel.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import Combine
import Foundation

@MainActor
final class CreateEventViewModel: ObservableObject {
    @Published var event: TPEvent
    @Published var alertMessage: String? = nil
    
    private let networkService: any NetworkServiceProtocol
    
    init(networkService: some NetworkServiceProtocol) {
        self.event = .init()
        self.networkService = networkService
    }
    
    func createEvent() async -> Bool {
        do {
            try await networkService.createEvent(for: event)
            return true
        } catch {
            alertMessage = "Ocorreu um erro ao criar o evento. Verifique se não faltaram informações importantes."
            return false
        }
    }
}
