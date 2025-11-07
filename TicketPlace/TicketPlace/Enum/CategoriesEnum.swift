//
//  CategoriesEnum.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 07/11/25.
//

import Foundation
 
enum CategoriesEnum: String, CaseIterable, Decodable {
    case show = "Show"
    case cinema = "Cinema"
    case aviationTravel = "Viagem Aérea"
    case busTravel = "Viagem de Ônibus"
    case theater = "Teatro"
    case sportingEvent = "Evento Esportivo"
    case conference = "Conferência"
}
