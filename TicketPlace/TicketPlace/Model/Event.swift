//
//  Event.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 06/11/25.
//

import Foundation

struct TPEvent: Identifiable, Hashable, Decodable {
    var id = UUID()
    
    var title: String
    var location: String
}
