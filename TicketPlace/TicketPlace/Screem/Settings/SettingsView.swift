//
//  SettingsView.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @EnvironmentObject private var coordinator: Coordinator
    @State private var showPasswordDialog = false
    
    var body: some View {
        VStack(alignment: .leading,spacing: GlobalConfigurations.normalSpacing) {
            Divider()
            
            Section("Email: ") {
                TPLockTextField(
                    text: $viewModel.userInfo.email,
                    isLocked: .constant(true),
                    imageName: "envelope.fill"
                )
            }
            
            Section("Nome de usuário: ") {
                TPLockTextField(
                    text: $viewModel.newUsername,
                    isLocked: $viewModel.isLocked,
                    imageName: "person.fill"
                )
            }
            
            
            Section("Senha: ") {
                TPLockPasswordTextField(text: $viewModel.newPassword, isLocked: $viewModel.isLocked, imageName: "lock.fill")
            }
            
            if !viewModel.isLocked {
                TPButton(title: "Salvar", color: .green.opacity(0.75)) {
                    Task {
                        await viewModel.saveChanges()
                    }
                }
                .transition(.opacity)
            }
            
        
            HStack(spacing: GlobalConfigurations.normalSpacing) {
                TPButton(title: "Deslogar", color: .gray.opacity(0.25)) {
                    try? KeychainService.delete(account: KeychainKeysEnum.accessToken)
                    coordinator.navigateToLoginView()
                }

            }
            
            if viewModel.isAdmin {
                Section("Administração: ") {
                    List {
                        NavigationLink {
                            controlPainel()
                        } label: {
                            HStack {
                                Image(systemName: "slider.horizontal.3")
                                Text("Painel de controle")
                            }
                            .foregroundStyle(.foreground)
                        }
                    }
                    .listStyle(.plain)
                }
            }
                
            
            Spacer()
        }
        .padding()
        .navigationTitle(Text("Configuração"))
        .blur(radius: showPasswordDialog ? 10 : 0)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit", systemImage: viewModel.isLocked ? "pencil" : "pencil.slash") {
                    if viewModel.isLocked {
                        withAnimation {
                            showPasswordDialog = true
                        }
                    } else {
                        viewModel.isLocked = true
                    }
                }
            }
        }
        .overlay {
            if showPasswordDialog {
                PasswordRequestView(
                    isPresented: $showPasswordDialog,
                    password: $viewModel.oldPassword,
                    verifyPassword: viewModel.verifyPassword) {
                        withAnimation {
                            viewModel.editModeToggled()
                        }
                    }
                    .transition(.scale)
                    .padding()
            }
        }
    }
    
    @ViewBuilder
    private func controlPainel() -> some View {
        ControlPanelView(title: "Painel de Controle") {
            ScrollView {
                if viewModel.allUsers.isEmpty {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                }
                
                ForEach(viewModel.isFiltering ? viewModel.filteredUsers : viewModel.allUsers, id: \.self) { user in
                    TPControlPanelRow(title: user.name, subtitle: user.email) {
                        viewModel.deleteUser(user)
                    }
                    .padding(.vertical)
                }
            }
            .scrollIndicators(.hidden)
        }
        .task {
            await viewModel.getUsers()
        }
        .refreshable {
            await viewModel.getUsers()
        }
        .searchable(text: $viewModel.searchText, prompt: "Busque por usuários")
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    let userInfo = UserResponse(id: UUID(), email: "", name: "", idGroup: 1)
    
    NavigationStack {
        SettingsView(viewModel: SettingsViewModel(userInfo: userInfo, networkService: NetworkService()))
    }
}

/*
 
 */
