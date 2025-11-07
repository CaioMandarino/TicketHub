//
//  EventDetailsView.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 06/11/25.
//

import SwiftUI

struct EventDetailsView: View {
    let event: TPEvent
    
    var body: some View {
        Text(event.title)
    }
}

#Preview {
    EventDetailsView(event: .init(title: "test", location: "test"))
}
