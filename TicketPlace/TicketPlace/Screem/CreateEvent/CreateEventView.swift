//
//  CreateEventView.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import SwiftUI

struct CreateEventView: View {
    @EnvironmentObject private var coordinator: Coordinator
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
                    Button("Salvar", systemImage: "checkmark") {
                        Task {
                            if await viewModel.createEvent() {
                                coordinator.navigateBack()
                            }
                        }
                    }
                }
            }
            .alert("Error", isPresented: .init(value: $viewModel.alertMessage)) {} message: {
                Text(viewModel.alertMessage ?? "Tente novamente mais tarde")
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
