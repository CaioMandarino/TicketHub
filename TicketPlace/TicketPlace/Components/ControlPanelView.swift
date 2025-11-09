//
//  ControlPanelView.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 09/11/25.
//

import SwiftUI

struct ControlPanelView<Content: View>: View {
    let title: String
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: GlobalConfigurations.normalSpacing) {
            HStack {
                Image(systemName: "slider.horizontal.3")
                Text(title)
                    .font(.headline)
                Spacer()
            }
            
            Divider()
            
            content
                .font(.subheadline)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.primary.opacity(0.1), lineWidth: 1)
        )
        .shadow(radius: 4, y: 2)
    }
}
#Preview {
    ControlPanelView(title: "Painel") {
        ScrollView {
            ForEach(1...5, id: \.self) { _ in
                Text("Item")
                    .frame(maxWidth: .infinity)
            }
        }
    }
}
