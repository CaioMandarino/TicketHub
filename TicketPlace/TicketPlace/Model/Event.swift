//
//  Event.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 06/11/25.
//

import Foundation

struct TPEvent: Identifiable, Hashable {
    var id: String
    
    var title: String
    var location: String
    var date: Date
    var details: String
    var reminder: ReminderEnum?
    var category: CategoriesEnum?

    init(
        id: String,
        title: String,
        location: String,
        date: Date,
        details: String,
        reminder: ReminderEnum? = nil,
        category: CategoriesEnum? = nil
    ) {
        self.id = id
        self.title = title
        self.location = location
        self.date = date
        self.details = details
        self.reminder = reminder
        self.category = category
    }
    
    init() {
        self.init(id: UUID().uuidString, title: "", location: "", date: .now.addingTimeInterval(3600), details: "")
    }
    
    func convertToEventData() throws -> EventData {
        guard let category else { throw URLError(.dataNotAllowed) }
        
        var detailsDictionary: [String: String] = [:]
        detailsDictionary["detalhes"] = details
            
        return EventData(idCategory: category.idCategory(), title: title, date: date, locale: location, details: detailsDictionary)
    }
}

extension TPEvent {
    var dateString: String {
        date.formatted(date: .abbreviated, time: .omitted)
    }
}
