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
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
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
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.ultraThinMaterial) // ou Color(.secondarySystemBackground)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
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
