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
    var date: Date
}

extension TPEvent {
    var dateString: String {
        date.formatted(date: .abbreviated, time: .omitted)
    }
}



extension Date {
    static func random(between start: Date, and end: Date) -> Date {
        let startTs = start.timeIntervalSince1970
        let endTs = end.timeIntervalSince1970
        let randTs = TimeInterval.random(in: startTs...endTs)
        return Date(timeIntervalSince1970: randTs)
    }
}

final class MockData {

    private static let startWindow = Calendar.current.date(byAdding: .day, value: -10, to: .now)!
    private static let endWindow   = Calendar.current.date(byAdding: .day, value: 30,  to: .now)!

    private static func randomDate() -> Date {
        .random(between: startWindow, and: endWindow)
    }

    static let events: [TPEvent] = [
        TPEvent(title: "Bar da 408 Norte",   location: "Asa Norte",        date: randomDate()),
        TPEvent(title: "Pontão Sunset Bar",  location: "Lago Sul",         date: randomDate()),
        TPEvent(title: "Feira Gastrô 215 Sul", location: "Asa Sul",        date: randomDate()),
        TPEvent(title: "Clube do Choro",     location: "Eixo Monumental",  date: randomDate()),
        TPEvent(title: "Terraço do Sudoeste",location: "Sudoeste",         date: randomDate()),
        TPEvent(title: "Bar do Parque",      location: "Parque da Cidade", date: randomDate()),
        TPEvent(title: "Varanda do Guará",   location: "Guará",            date: randomDate()),
        TPEvent(title: "Armazém Noroeste",   location: "Noroeste",         date: randomDate())
    ]
}
