//
//  UserResponse.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import Foundation

struct UserResponse: Decodable, Hashable {
    let id: String
    var email: String
    var name: String
    var idGroup: Int

    enum CodingKeys: String, CodingKey {
        case email
        case name = "nome_completo"
        case id = "id_usuario"
        case idGroup = "id_grupo"
    }
    
    init(id: String, email: String, name: String, idGroup: Int = 2) {
        self.id = id
        self.email = email
        self.name = name
        self.idGroup = idGroup
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        email = try container.decode(String.self, forKey: .email)
        name = try container.decode(String.self, forKey: .name)
        idGroup = try container.decodeIfPresent(Int.self, forKey: .idGroup) ?? 2
    }
}
