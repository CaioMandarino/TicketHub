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
            
            //TODO: Admin
            if viewModel.isAdmin {
                ControlPanelView(title: "Painel de Controle") {
                    ScrollView {
                        ForEach(1...5, id: \.self) { _ in
                            TPControlPanelRow(title: "", subtitle: "") {
                                
                            }
                            .padding(.vertical)
                        }
                    }
                    .scrollIndicators(.hidden)
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
}

#Preview {
    NavigationStack {
        SettingsView(viewModel: SettingsViewModel(userInfo: nil, networkService: NetworkService()))
    }
}
