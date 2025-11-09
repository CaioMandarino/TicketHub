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
    case login
    case register
    
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
        case .login:
            coordinate.createLoginView()
        case .register:
            coordinate.createRegisterView()
        }
    }
    
    
}
