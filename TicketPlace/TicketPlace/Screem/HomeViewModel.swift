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
    @Published var username: String? = "Caio" // TODO: Implementar
    
    var isFiltering: Bool {
        !searchText.isEmpty
    }
    
    private let networkService: any NetworkServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: some NetworkServiceProtocol) {
        self.networkService = networkService
        
        observableSearchTextDidChange()
    }
    
    func fetchEvents() async {
        isLoading = true
        let url: URL = URL(string: "http://localhost:3000/events")!
        let request: URLRequest = .init(url: url)
        
        try? await Task.sleep(for: .seconds(5))
        isLoading = false
        events = MockData.events
        return
        
//        do {
//            let events = try await networkService.fetchData(Array<TPEvent>.self, from: request)
//            isLoading = false
//            self.events = events
//            
//        } catch {
//            isLoading = false
//            alertMessage = "Requisição mal sucedida. Tente novamente mais tarde."
//        }
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


final class MockData {
    static let events: [TPEvent] = [
        TPEvent(
            title: "Bar da 408 Norte",
            location: "Asa Norte"
        ),

        TPEvent(
            title: "Pontão Sunset Bar",
            location: "Lago Sul"
        ),

        TPEvent(
            title: "Feira Gastrô 215 Sul",
            location: "Asa Sul"
        ),

        TPEvent(
            title: "Clube do Choro",
            location: "Eixo Monumental"
        ),

        TPEvent(
            title: "Terraço do Sudoeste",
            location: "Sudoeste"
        ),

        TPEvent(
            title: "Bar do Parque",
            location: "Parque da Cidade"
        ),

        TPEvent(
            title: "Varanda do Guará",
            location: "Guará"
        ),

        TPEvent(
            title: "Armazém Noroeste",
            location: "Noroeste"
        )

    ]
}
