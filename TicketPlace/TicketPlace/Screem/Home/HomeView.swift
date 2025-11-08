//
//  HomeView.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 06/11/25.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.isFiltering ? viewModel.filteredEvents : viewModel.events) { event in
                    TPListRow(title: event.title, location: event.location) {
                        coordinator.navigateToDetailsView(event: event)
                    }
                }
                .onDelete(perform: viewModel.deleteEvent)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .background {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
        }
        .overlay(alignment: .bottomTrailing) {
            TPAddEventButton {
                coordinator.navigateToCreateEventView()
            }
            .padding()
        }
        .searchable(text: $viewModel.searchText, prompt: Text("Busque um evento..."))
        .navigationTitle(Text("Olá, \(viewModel.username ?? "Desconhecido")"))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Settings", systemImage: "gear") {
                    coordinator.navigateToSettingsView()
                }
            }
        }
        .task {
            Task {
                await viewModel.fetchUser()
            }
            
            Task {
                await viewModel.fetchEvents()
            }
        }
        .refreshable {
            await viewModel.fetchEvents()
        }
        .alert("Error", isPresented: .init(value: $viewModel.alertMessage)) {} message: {
            Text(viewModel.alertMessage ?? "Tente novamente mais tarde")
        }
        
    }
}

#Preview {
    NavigationStack {
        HomeView(viewModel: HomeViewModel(networkService: NetworkService() ))
    }
}
