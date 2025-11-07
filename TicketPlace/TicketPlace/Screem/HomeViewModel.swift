//
//  HomeViewModel.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 06/11/25.
//

import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var events: [TPEvent] = MockData.events
    
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
