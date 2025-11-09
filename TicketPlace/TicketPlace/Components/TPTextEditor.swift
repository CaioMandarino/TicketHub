//
//  TPTextEditor.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 07/11/25.
//

import SwiftUI

struct TPTextEditor: View {
    @Binding var text: String
    var placeholder: String = "Digite aqui…"

    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .allowsHitTesting(false)
            }

            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .background(.clear)
                .frame(minHeight: 100, maxHeight: 150)
                .padding(.horizontal, 4)
        }
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 1)
        )
    }
}


#Preview {
    @Previewable @State var text: String = ""
    VStack {
        TPTextEditor(text: $text)
    }
}
