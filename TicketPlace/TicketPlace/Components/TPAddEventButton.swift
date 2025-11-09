//
//  TPAddEventButton.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 07/11/25.
//

import SwiftUI

struct TPAddEventButton: View {
    let onAction: () -> Void
    
    var body: some View {
        Button {
            onAction()
        } label: {
            Image(systemName: "plus")
                .foregroundStyle(.foreground)
                .font(.title)
                .padding(GlobalConfigurations.smallPadding)
                .background {
                    Circle()
                        .fill(.background)
                }
                .overlay(
                    Circle()
                        .stroke(lineWidth: 1)
                        .foregroundStyle(.foreground)
                )
                .shadow(radius: 2)
        }
        .buttonStyle(TPButtonStyle())
    }
}

#Preview {
    TPAddEventButton {
        
    }
}
