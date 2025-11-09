//
//  PasswordRequestView.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import SwiftUI

struct PasswordRequestView: View {
    
    @State private var showAlert: Bool = false
    
    @Binding var isPresented: Bool
    @Binding var password: String
    
    let verifyPassword: () async -> Bool
    let action: () -> Void
    
    var body: some View {
        VStack {
            Text("Senha ")
                .font(.title)
                .fontWeight(.semibold)
            
            TPPasswordTextField(
                text: $password,
                imageName: "lock.fill",
                prompt: Text("Digite sua senha...")
            )
            
            HStack(spacing: GlobalConfigurations.normalSpacing) {
                TPButton(title: "Cancelar", color: .red.opacity(0.75)) {
                    withAnimation {
                        isPresented = false
                    }
                }
                
                TPButton(title: "Editar", color: .green.opacity(0.75)) {
                    Task {
                        if await verifyPassword() {
                            action()
                            withAnimation {
                                isPresented = false
                            }
                        } else {
                            showAlert = true
                        }
                    }
                }
            }
            .padding(.vertical)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.background)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 1)
        }
        .alert("Senha Incorreta", isPresented: $showAlert) {}
    }
}

#Preview {
    PasswordRequestView(isPresented: .constant(true), password: .constant("********")) {
        return false
    } action: {
        
    }

}
