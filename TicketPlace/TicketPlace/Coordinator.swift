//
//  Coordinator.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 06/11/25.
//

import SwiftUI
import Combine

final class Coordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    private let homeViewModel: HomeViewModel
    private let networkService: any NetworkServiceProtocol
    
    init() {
        networkService = NetworkService()
        homeViewModel = .init(networkService: networkService)
    }
    
    func navigateToHomeView() -> some View {
        return HomeView(viewModel: homeViewModel)
    }
    
    func navigateToDetailsView(event: TPEvent) {
        path.append(event)
    }
    
}
