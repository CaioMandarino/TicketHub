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
    case travel = "Viagem"
    case theater = "Teatro"
    case sportingEvent = "Esportivo"
    case conference = "Conferência"
}
