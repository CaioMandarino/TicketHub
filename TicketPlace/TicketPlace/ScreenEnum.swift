//
//  ScreenEnum.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 07/11/25.
//

import SwiftUI

enum ScreenEnum: Hashable {
    case home
    case details(TPEvent)
    case createEvent
    case settings
    
    @ViewBuilder
    func createView(with coordinate: Coordinator) -> some View {
        switch self {
        case .home:
            coordinate.createHomeView()
        case .createEvent:
            coordinate.createCreateEventView()
        case .settings:
            coordinate.createSettingsView()
        case .details(let event):
            coordinate.createDetailsView(event: event)
        }
    }
    
    
}
