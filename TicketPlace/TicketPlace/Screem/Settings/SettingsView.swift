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
    
    var body: some View {
        VStack(spacing: GlobalConfigurations.normalSpacing) {
            Divider()
            
            TPLockTextField(
                text: $viewModel.userInfo.name,
                isLocked: $viewModel.isLocked,
                imageName: "person.fill"
            )
            
            TPLockTextField(
                text: $viewModel.userInfo.email,
                isLocked: $viewModel.isLocked,
                imageName: "envelope.fill"
            )
            
            // TODO: Ver como a senha vai ser mostrada
        
            HStack(spacing: GlobalConfigurations.normalSpacing) {
                TPButton(title: "Deslogar", color: .gray.opacity(0.25)) {
                    try? KeychainService.delete(account: KeychainKeysEnum.accessToken)
                    coordinator.navigateToLoginView()
                }
                
                TPButton(title: "Apagar Conta", color: .red.opacity(0.75)) {
                    // TODO: Implementar o apagar
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(Text("Configuração"))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit", systemImage: viewModel.isLocked ? "pencil.slash" : "pencil") {
                    viewModel.isLocked.toggle()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView(viewModel: SettingsViewModel(userInfo: nil))
    }
}
