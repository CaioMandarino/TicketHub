//
//  EventsResponse.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import Foundation

struct EventsResponse: Decodable, Identifiable {
    let idCategory: Int
    let title: String
    let date: Date
    let locale: String
    let idEvent: String
    let categoryName: String
    let details: [String: [String: String]]?

    var id: String { idEvent }

    enum CodingKeys: String, CodingKey {
        case idCategory   = "id_categoria"
        case title
        case date = "data_hora_inicio"
        case locale   = "local_evento"
        case idEvent      = "id_evento"
        case categoryName = "nome_categoria"
        case details = "detalhes_mongo"
    }
    
    func convertToEvent() -> TPEvent {
        
        let detailsDictionary: [String: String] = details?["detalhes"] ?? [:]
        let details = detailsDictionary["detalhes"] ?? ""

        return TPEvent(
            title: title,
            location: locale,
            date: date,
            details: details,
            category: .cinema
        )
    }
}
