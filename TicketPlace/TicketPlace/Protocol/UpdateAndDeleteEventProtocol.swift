//
//  UpdateAndDeleteEventProtocol.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 07/11/25.
//

import Foundation

protocol UpdateAndDeleteEventProtocol: AnyObject {
    func updateEvent(for id: UUID, with event: TPEvent) -> Void
    func deleteEvent(for id: UUID) -> Void
}
