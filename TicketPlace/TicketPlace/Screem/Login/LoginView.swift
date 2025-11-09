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
        VStack(alignment: .leading, spacing: GlobalConfigurations.normalSpacing) {
            Text("Ticket Hub")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.vertical, GlobalConfigurations.normalPadding)
                .frame(maxWidth: .infinity)
            
            
            TPTextField(text: $viewModel.email, imageName: "envelope.fill", prompt: Text("Digite seu email"))
            
            TPPasswordTextField(text: $viewModel.password, imageName: "lock.fill", prompt: Text("Digite sua senha"))
            
            TPStayLoginButton()
                .padding(.horizontal)
            
            TPButton(title: "Entrar", color: .gray.opacity(0.25)) {
                Task {
                    if await viewModel.login() {
                        coordinator.navigateToHomeView()
                    } 
                }
            }
            .padding(GlobalConfigurations.largePadding)
            .disabled(!viewModel.isFormValid)
            .opacity(!viewModel.isFormValid ? 0.5 : 1)
            
            Text("Ainda não tem uma conta?")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, GlobalConfigurations.smallPadding)
                .onTapGesture {
                    coordinator.navigateToRegisterView()
                }
                .frame(maxWidth: .infinity)
            
        }
        .padding(GlobalConfigurations.normalPadding)
        .alert("Error", isPresented: Binding(value: $viewModel.alertMessage)) {
            
        } message: {
            Text(viewModel.alertMessage ?? "Tente novamente mais tarde")
        }

    }
}

#Preview {
    LoginView(viewModel: LoginViewModel(networkService: NetworkService()))
}
