//
//  TPControlPanelRow.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 09/11/25.
//

import SwiftUI

struct TPControlPanelRow: View {
    let title: String
    let subtitle: String
    
    let action: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                
                Text(subtitle)
                    .foregroundStyle(.secondary)
            }
            .lineLimit(1)
            .minimumScaleFactor(0.9)
            
            Spacer()
            
            Button {
                action()
            } label: {
                Image(systemName: "trash.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.background, .foreground)
                    .frame(maxWidth: 30, maxHeight: 30)

            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 1)
        }
    }
}

#Preview {
    TPControlPanelRow(title: "Caio Mandarino", subtitle: "caiomandarino@gmail.com") {}
}
