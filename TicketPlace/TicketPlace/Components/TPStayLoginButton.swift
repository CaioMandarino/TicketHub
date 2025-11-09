//
//  TPStayLoginButton.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import SwiftUI

struct TPStayLoginButton: View {
    @AppStorage(KeychainKeysEnum.stayLoggedIn) var stayLogin: Bool = false
    
    var body: some View {
        HStack {
            Button("", systemImage: stayLogin ? "checkmark.square" : "square") {
                stayLogin.toggle()
            }
            .foregroundStyle(.foreground)
            
            Text("Lembre - me")
        }
        .font(.headline)
    }
}

#Preview {
    TPStayLoginButton()
}
