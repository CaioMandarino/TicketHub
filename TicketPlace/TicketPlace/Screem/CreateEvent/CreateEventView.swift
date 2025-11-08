//
//  CreateEventView.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import SwiftUI

struct CreateEventView: View {
    @ObservedObject var viewModel: CreateEventViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: GlobalConfigurations.normalSpacing) {
    
                Divider()
                
                Section("Título: ") {
                    TPTextField(text: $viewModel.event.title, prompt: Text("Nome do evento"))
                }
                
                Section("Local: ") {
                    TPTextField(text: $viewModel.event.location, prompt: Text("Local do evento"))
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
            .navigationTitle(Text("Criar Evento"))
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .destructiveAction) {
                    Button("Salvar", systemImage: "square.and.arrow.down", role: .confirm) {
                        Task {
                            await viewModel.createEvent()
                        }
                    }
                }
            }
            
            
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    NavigationStack {
        CreateEventView(viewModel: .init(networkService: NetworkService()))
    }
}
