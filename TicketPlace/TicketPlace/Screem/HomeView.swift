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
                ForEach(viewModel.events) { event in
                    TPListRow(title: event.title, location: event.location) {
                        coordinator.navigateToDetailsView(event: event)
                    }
                }
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
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer, prompt: Text("Busque um evento..."))
        .navigationTitle(Text("Olá, mundo!"))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Settings", systemImage: "gear") {
                    
                }
            }
        }
        .task {
            await viewModel.fetchEvents()
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
