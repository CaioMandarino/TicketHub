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
    case newUsername
    case newPassword
    case getUsers
    
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
        case .newUsername:
            return "users/me/profile"
        case .newPassword:
            return "users/me/password"
        case .getUsers:
            return "admin/users/search"
        }
    }
}
