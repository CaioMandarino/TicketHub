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
    @Published var showLogin: Bool
    
    private let homeViewModel: HomeViewModel
    private let networkService: any NetworkServiceProtocol
    
    init() {
        networkService = NetworkService()
        homeViewModel = .init(networkService: networkService)
        
        let stayLogin = UserDefaults.standard.bool(forKey: KeychainKeysEnum.stayLoggedIn)
        
        if let _ = try? KeychainService.read(account: KeychainKeysEnum.accessToken), stayLogin {
            showLogin = false
        } else {
            showLogin = true
        }
        
        homeViewModel.coordinator = self
    }
    
    func createHomeView() -> some View {
        return HomeView(viewModel: homeViewModel)
    }
    
    func createDetailsView(event: TPEvent) -> some View {
        let viewModel = EventDetailsViewModel(event: event, service: homeViewModel)
        return EventDetailsView(viewModel: viewModel)
    }
    
    func createLoginView() -> some View {
        return LoginView(viewModel: LoginViewModel(networkService: networkService))
    }
    
    func createRegisterView() -> some View {
        return RegisterView(viewModel: RegisterViewModel(networkService: networkService))
    }
    
    func createSettingsView() -> some View {
        EmptyView() // TODO: Fazer a Settings View
    }
    
    func createCreateEventView() -> some View {
        CreateEventView(viewModel: CreateEventViewModel(networkService: networkService))
    }
    
    func navigateToDetailsView(event: TPEvent) {
        path.append(ScreenEnum.details(event))
    }
    
    func navigateToCreateEventView() {
        path.append(ScreenEnum.createEvent)
    }
    
    func navigateToSettingsView() {
        // TODO: Fazer a navegação para a tela de configuração
    }
    
    func navigateToRegisterView() {
        path.append(ScreenEnum.register)
    }
    
    func navigateToHomeView() {
        path.removeLast(path.count)
        showLogin = false
    }
    
    func navigateToLoginView() {
        path.removeLast(path.count)
        showLogin = true
    }
    
    func navigateBack() {
        path.removeLast()
    }
}


