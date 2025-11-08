//
//  HomeViewModel.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 06/11/25.
//

import Combine
import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var events: [TPEvent] = []
    @Published var filteredEvents: [TPEvent] = []
    @Published var alertMessage: String? = nil
    @Published var isLoading: Bool = false
    @Published var username: String? = nil
    
    var isFiltering: Bool {
        !searchText.isEmpty
    }
    
    private var userInfo: UserResponse? = nil
    private let networkService: any NetworkServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: some NetworkServiceProtocol) {
        self.networkService = networkService
        
        observableSearchTextDidChange()
    }
    
    func fetchUser() async {
        do {
            self.userInfo = try await networkService.userInfo()
            username = userInfo?.name
            
        } catch URLError.userAuthenticationRequired {
            print("Problemas ao buscar informações do usuário")
            try? KeychainService.delete(account: KeychainKeysEnum.accessToken)
            // TODO: Fazer logout
        } catch {
            print("Problemas ao buscar informações do usuário")
        }
    }
    
    func fetchEvents() async {
        
    }
    
    func deleteEvent(for indexSet: IndexSet) {
        for index in indexSet {
            events.remove(at: index)
            // TODO: Remover do Backend
        }
    }
    
    private func observableSearchTextDidChange() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                guard let self else { return }
                
                let term = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

                if term.isEmpty {
                    filteredEvents = events
                } else {
                    filteredEvents = events.filter { event in
                        event.title.localizedCaseInsensitiveContains(term) || (event.location.localizedCaseInsensitiveContains(term))
                    }
                }
                
            }
            .store(in: &cancellables)
    }
}

extension HomeViewModel: UpdateAndDeleteEventProtocol {
    func deleteEvent(for id: UUID) {
        guard let index = events.firstIndex(where: { $0.id == id }) else { return }

        events.remove(at: index)
    }
    
    func updateEvent(for id: UUID, with newEvent: TPEvent) {
        guard let index = events.firstIndex(where: { $0.id == id }) else { return }
        
        events[index] = newEvent
    }
    
    
}
