//
//  RegisterView.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject var viewModel: RegisterViewModel
    @EnvironmentObject private var coordinator: Coordinator
        
    var body: some View {
        VStack(spacing: GlobalConfigurations.normalSpacing) {
            Divider()
            
            Spacer()
            
            Text("Seja Bem Vindo!")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.vertical)
            
            TPTextField(text: $viewModel.username, imageName: "person.fill", prompt: Text("Digite seu nome de usuário"))
            
            TPTextField(text: $viewModel.email, imageName: "envelope.fill", prompt: Text("Digite seu email"))
            
            TPPasswordTextField(text: $viewModel.password, imageName: "lock.fill", prompt: Text("Digite sua senha"))

            TPButton(title: "Criar Conta") {
                Task {
                    if await viewModel.createAccount() {
                        coordinator.navigateToHomeView()
                    }
                }
            }
            .padding(GlobalConfigurations.largePadding)
            
            Spacer()
        }
        .navigationTitle(Text("Criar Conta"))
        .padding(.horizontal)
    }

}

#Preview {
    NavigationStack {
        RegisterView(viewModel: .init(networkService: NetworkService()))
    }
}
