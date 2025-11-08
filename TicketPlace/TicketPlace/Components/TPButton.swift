//
//  TPButton.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import SwiftUI

struct TPButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .frame(maxWidth: .infinity)
                .font(.headline)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.gray.opacity(0.25))
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 1)
                }
                .shadow(radius: 10)
            
        }
        .foregroundStyle(.foreground)
        .buttonStyle(TPButtonStyle())

    }
}

#Preview {
    TPButton(title: "Logar") {
        
    }
    .padding(.horizontal)
}
