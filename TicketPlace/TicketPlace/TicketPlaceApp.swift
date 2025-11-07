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
                HomeView(viewModel: HomeViewModel())
                    .environmentObject(coordinator)
                    .navigationDestination(for: TPEvent.self) { event in
                        EventDetailsView(event: event)
                    }
            }
        }
    }
}
