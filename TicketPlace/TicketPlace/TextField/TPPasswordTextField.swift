//
//  TPPasswordTextField.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 06/11/25.
//

import SwiftUI

struct TPPasswordTextField: View {
    
    @State private var showPassword: Bool = false
    
    @Binding var text: String
    let imageName: String
    let prompt: Text?
    
    var body: some View {
        HStack(spacing: GlobalConfigurations.normalSpacing) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 30)

            if showPassword {
                TextField("TextField", text: $text, prompt: prompt )
            } else {
                SecureField("PasswordTextField", text: $text, prompt: prompt )
            }
            
            Spacer()
            
            Button {
                showPassword.toggle()
            } label: {
                if showPassword {
                    Image(systemName: "eye")
                        .transition(.symbolEffect(.drawOn))
                        .symbolRenderingMode(.monochrome)
                        .foregroundStyle(.foreground)
                } else {
                    Image(systemName: "eye.slash")
                        .transition(.symbolEffect(.drawOff))
                        .symbolRenderingMode(.monochrome)
                        .foregroundStyle(.foreground)
                }
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15)
                .stroke(style: StrokeStyle(lineWidth: 1))
        }
    }
}

#Preview {
    @Previewable @State var text: String = ""
    
    TPPasswordTextField(text: $text, imageName: "lock.fill", prompt: Text("Senha"))
        .padding(.horizontal)
}
