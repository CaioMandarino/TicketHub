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
    var details: String
    var reminder: ReminderEnum?
    var category: CategoriesEnum?

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
        TPEvent(
            title: "Bar da 408 Norte",
            location: "Asa Norte",
            date: randomDate(),
            details: "Happy hour com música ao vivo (samba/MPB). Promoção de chope até 20h. Área externa pet-friendly.",
            category: .travel
        ),
        TPEvent(
            title: "Pontão Sunset Bar",
            location: "Lago Sul",
            date: randomDate(),
            details: "Vista para o lago, DJ ao pôr do sol e drinks autorais. Recomenda-se chegar às 17h para pegar mesa.",
            category: .cinema
        ),
        TPEvent(
            title: "Feira Gastrô 215 Sul",
            location: "Asa Sul",
            date: randomDate(),
            details: "Feira de street food com 20+ expositores, opções veganas, mesas compartilhadas e música ambiente.",
            category: .travel
        ),
        TPEvent(
            title: "Clube do Choro",
            location: "Eixo Monumental",
            date: randomDate(),
            details: "Show instrumental de choro e gafieira. Mesas por ordem de chegada. Couvert artístico R$ 30.",
            category: .show
        ),
        TPEvent(
            title: "Terraço do Sudoeste",
            location: "Sudoeste",
            date: randomDate(),
            details: "Rooftop com banda pop/rock anos 90, pista de dança e menu de tapas. Estacionamento no local.",
            category: .cinema
        ),
        TPEvent(
            title: "Bar do Parque",
            location: "Parque da Cidade",
            date: randomDate(),
            details: "Programa ao ar livre; jazz acústico, cadeiras de praia e menu leve. Leve agasalho para a noite.",
            category: .show
        ),
        TPEvent(
            title: "Varanda do Guará",
            location: "Guará",
            date: randomDate(),
            details: "Sertanejo universitário acústico; promoção de caipirinhas; ambiente família até 22h.",
            category: .show
        ),
        TPEvent(
            title: "Armazém Noroeste",
            location: "Noroeste",
            date: randomDate(),
            details: "Telão 4K para final de campeonato, mesas altas e double chopp no intervalo.",
            category: .sportingEvent
        )
    ]

}
