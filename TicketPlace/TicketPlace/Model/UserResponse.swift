//
//  UserResponse.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import Foundation

struct UserResponse: Decodable {
    let id: UUID
    let email: String
    let name: String
    let idGroup: Int

    enum CodingKeys: String, CodingKey {
        case email
        case name = "nome_completo"
        case id = "id_usuario"
        case idGroup = "id_grupo"
    }
}
