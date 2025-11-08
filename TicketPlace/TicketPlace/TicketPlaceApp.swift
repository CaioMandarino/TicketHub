//
//  TicketPlaceApp.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 06/11/25.
//

import SwiftUI

@main
struct TicketPlaceApp: App {
    
    @StateObject private var coordinator: Coordinator = .init()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                coordinator.createHomeView()
                    .navigationDestination(for: ScreenEnum.self) { screen in
                        screen.createView(with: coordinator)
                    }
            }
            .environmentObject(coordinator)
        }
    }
}
