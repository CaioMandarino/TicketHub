//
//  EventDetailsView.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 06/11/25.
//

import SwiftUI

struct EventDetailsView: View {
    @ObservedObject var viewModel: EventDetailsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: GlobalConfigurations.normalSpacing) {
            Text(viewModel.event.dateString)
            
            Divider()
            
            Section("Título: ") {
                TPTextField(text: $viewModel.event.title)
            }
            
            Section("Local: ") {
                TPTextField(text: $viewModel.event.location)
            }
            
            Spacer()
        }
        .navigationTitle(Text(viewModel.event.title))
        .padding(.horizontal)
        .onDisappear {
            viewModel.saveEvent()
        }
    }
}

#Preview {
    let viewModel = EventDetailsViewModel(event: MockData.events.first!) { _ , _ in
    }
    NavigationStack {
        EventDetailsView(viewModel: viewModel)
    }
}
