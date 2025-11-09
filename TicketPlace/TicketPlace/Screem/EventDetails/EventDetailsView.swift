//
//  EventDetailsView.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 06/11/25.
//

import SwiftUI

struct EventDetailsView: View {
    @ObservedObject var viewModel: EventDetailsViewModel
    @EnvironmentObject private var coordinator: Coordinator
    
    @State private var showDeleteDialog = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: GlobalConfigurations.normalSpacing) {
                Text(viewModel.event.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    
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
            .navigationTitle(Text("Editar Evento"))
            .padding(.horizontal)
            .onDisappear {
                if !viewModel.isDeleted {
                    viewModel.saveEvent()
                }
            }
            .toolbar {
                ToolbarItem(placement: .destructiveAction) {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        showDeleteDialog = true
                    }
                }
            }
            .confirmationDialog(
                "Deletar Evento",
                isPresented: $showDeleteDialog,
                titleVisibility: .visible
            ) {
                Button("Deletar", role: .destructive) {
                    viewModel.deleteEvent()
                    coordinator.navigateBack()
                }
            }
            
            
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    let viewModel = EventDetailsViewModel(event: .init(), service: HomeViewModel(networkService: NetworkService()))
    
    NavigationStack {
        EventDetailsView(viewModel: viewModel)
    }
}
