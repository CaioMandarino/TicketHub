//
//  TPTextField.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 06/11/25.
//

import SwiftUI

struct TPTextField: View {
    @Binding var text: String
    let imageName: String
    let prompt: Text?
    
    var body: some View {
        HStack(spacing: GlobalConfigurations.normalSpacing) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 30)

            TextField("TextField", text: $text, prompt: prompt )
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15)
                .stroke(style: StrokeStyle(lineWidth: 1))
        }
    }
}

#Preview {
    let prompt = Text("E-mail")
    TPTextField(text: .constant(""), imageName: "person.fill", prompt: prompt)
        .padding(.horizontal)
}
