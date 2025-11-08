//
//  LoginResponse.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import Foundation

struct LoginResponse: Decodable {
    let accessToken: String
    let tokenType: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType   = "token_type"
    }
}
