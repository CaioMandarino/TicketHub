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
    let extraInformation: ExtraInformation?

    var id: String { idEvent }

    enum CodingKeys: String, CodingKey {
        case idCategory   = "id_categoria"
        case title = "titulo"
        case date = "data_hora_inicio"
        case locale  = "local_evento"
        case idEvent = "id_evento"
        case categoryName = "nome_categoria"
        case extraInformation = "detalhes_mongo"
    }
    
    func convertToEvent() -> TPEvent {
        
        let details = extraInformation?.details ?? ""

        return TPEvent(
            id: idEvent,
            title: title,
            location: locale,
            date: date,
            details: details,
            category: CategoriesEnum.idCategory(id: idCategory)
        )
    }
}

struct ExtraInformation: Decodable {
    let id: String?
    let details: String?

    enum CodingKeys: String, CodingKey {
        case id       = "_id"
        case detalhes = "detalhes"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try? container.decode(String.self, forKey: .id)

        if let rawString = try? container.decode(String.self, forKey: .detalhes) {
            details = rawString
        }
        
        else {
            details = nil
        }
    }
}

