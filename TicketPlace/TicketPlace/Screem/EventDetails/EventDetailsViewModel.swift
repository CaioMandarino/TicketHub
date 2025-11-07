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
    let updateEvent: (UUID, TPEvent) -> Void
    
    init(event: TPEvent, updateEvent: @escaping (UUID, TPEvent) -> Void) {
        self.event = event
        self.updateEvent = updateEvent
    }
    
    func saveEvent() {
        updateEvent(event.id, event)
    }
}
