//
//  TPListRow.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 06/11/25.
//

import SwiftUI

struct TPListRow: View {
    
    let title: String
    let location: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                    Text(location)
                        .font(.subheadline)
                }
                
                Spacer()
                
                Text("Ver mais")
                    .opacity(0.5)
                
                Image(systemName: "chevron.right")
                    .bold()
                    .opacity(0.5)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 1)
            }
        }
        .buttonStyle(TPButtonStyle())
    }
}

#Preview {
    TPListRow(title: "Bar da 102 sul", location: "Asa Sul") {
        
    }
    .padding(.horizontal)
}



