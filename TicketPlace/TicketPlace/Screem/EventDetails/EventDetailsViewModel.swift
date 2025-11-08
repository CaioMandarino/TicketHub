//
//  EventDetailsViewModel.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 07/11/25.
//

import Combine
import Foundation

final class EventDetailsViewModel: ObservableObject {
    @Published var event: TPEvent
    
    private let service: any UpdateAndDeleteEventProtocol
    var isDeleted: Bool = false
    
    init(event: TPEvent, service: some UpdateAndDeleteEventProtocol) {
        self.event = event
        self.service = service
    }
    
    func saveEvent() {
        guard isDeleted == false else { return }
        
        service.updateEvent(for: event.id, with: event)
    }
    
    func deleteEvent() {
        isDeleted = true
        service.deleteEvent(for: event.id)
    }
}
