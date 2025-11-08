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
    
    func idCategory() -> Int {
        switch self {
        case .show:
            return 1
        case .cinema:
            return 2
        case .travel:
            return 3
        case .theater:
            return 4
        case .sportingEvent:
            return 5
        case .conference:
            return 6
        }
    }
    
    static func idCategory(id: Int) -> CategoriesEnum? {
        switch id {
        case 1:
            return .show
        case 2:
            return .cinema
        case 3:
            return .travel
        case 4:
            return .theater
        case 5:
            return .sportingEvent
        case 6:
            return .conference
        default:
            return nil
        }
    }
}
