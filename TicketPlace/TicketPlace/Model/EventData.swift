//
//  EventData.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import Foundation

struct EventData: Encodable {
    let idCategory: Int
    let title: String
    let date: Date
    let locale: String
    let details: [String: String]?

    enum CodingKeys: String, CodingKey {
        case idCategory   = "id_categoria"
        case title  = "titulo"
        case date = "data_hora_inicio"
        case locale   = "local_evento"
        case details    = "dados_mongo"
    }
}
