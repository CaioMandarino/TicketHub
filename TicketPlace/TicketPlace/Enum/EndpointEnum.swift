//
//  EndpointEnum.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import Foundation

enum EndpointEnum {
    case register
    case login
    case userInfo
    case events
    case newEvent
    case updateEvent(id: String)
    case deleteEvent(id: String)

    var path: String {
        switch self {
        case .register:
            return "register"
        case .login:
            return "login"
        case .userInfo:
            return "users/me"
        case .events:
            return "agenda/"
        case .newEvent:
            return "eventos/"
        case .updateEvent(let id):
            return "eventos/\(id)"
        case .deleteEvent(id: let id):
            return "eventos/\(id)"
        }
    }
}
