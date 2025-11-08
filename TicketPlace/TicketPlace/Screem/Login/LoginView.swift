//
//  LoginView.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack(spacing: GlobalConfigurations.normalSpacing) {
            Text("Ticket Hub")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.vertical, GlobalConfigurations.normalPadding)
            
            
            TPTextField(text: $viewModel.email, imageName: "envelope.fill", prompt: Text("Digite seu email"))
            
            TPPasswordTextField(text: $viewModel.password, imageName: "lock.fill", prompt: Text("Digite sua senha"))
            
            TPButton(title: "Entrar") {
                Task {
                    if await viewModel.login() {
                        coordinator.navigateToHomeView()
                    }
                }
            }
            .padding(GlobalConfigurations.largePadding)
            
            Text("Ainda não tem uma conta?")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, GlobalConfigurations.smallPadding)
                .onTapGesture {
                    coordinator.navigateToRegisterView()
                }
            
        }
        .padding(GlobalConfigurations.normalPadding)
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel(networkService: NetworkService()))
}
