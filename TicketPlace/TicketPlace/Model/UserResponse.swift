//
//  UserResponse.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import Foundation

struct UserResponse: Decodable {
    let id: UUID
    var email: String
    var name: String
    var idGroup: Int

    enum CodingKeys: String, CodingKey {
        case email
        case name = "nome_completo"
        case id = "id_usuario"
        case idGroup = "id_grupo"
    }
}
