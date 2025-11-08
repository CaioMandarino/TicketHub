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
        ScrollView {
            VStack(alignment: .leading, spacing: GlobalConfigurations.normalSpacing) {
                Text(viewModel.event.dateString)
                
                Divider()
                
                Section("Título: ") {
                    TPTextField(text: $viewModel.event.title)
                }
                
                Section("Local: ") {
                    TPTextField(text: $viewModel.event.location)
                }
                
                Divider()
                
                TPPicker(
                    "Lembrete",
                    selection: $viewModel.event.reminder,
                    noneText: "Nenhum",
                    includeNone: true
                )
                
                TPPicker("Categoria", selection: $viewModel.event.category)
                
                TPDateTimeSelection(date: $viewModel.event.date)
                
                Divider()
                
                Section("Detalhes: ") {
                    TPTextEditor(text: $viewModel.event.details)
                }
                
            }
            .navigationTitle(Text(viewModel.event.title))
            .padding(.horizontal)
            .onDisappear {
                viewModel.saveEvent()
            }
            .toolbar {
                ToolbarItem(placement: .destructiveAction) {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    let viewModel = EventDetailsViewModel(event: MockData.events.first!) { _ , _ in
    }
    NavigationStack {
        EventDetailsView(viewModel: viewModel)
    }
}
