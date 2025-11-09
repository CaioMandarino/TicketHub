//
//  User.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import Foundation

struct UserData: Encodable {
    let email: String
    let password: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case email, password
        case name = "nome_completo"
    }
}
