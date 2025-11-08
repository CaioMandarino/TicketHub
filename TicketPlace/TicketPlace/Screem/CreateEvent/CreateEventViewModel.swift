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
    private let networkService: any NetworkServiceProtocol
    
    init(networkService: some NetworkServiceProtocol) {
        self.event = .init()
        self.networkService = networkService
    }
    
    func createEvent() async {
        do {
            try await networkService.createEvent(for: event)
            
        } catch {
            
        }
    }
}
