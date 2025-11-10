//
//  TPLockPasswordTextField.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 06/11/25.
//

import SwiftUI

struct TPLockPasswordTextField: View {
    @State private var showPassword: Bool = false
    @State private var showEffect: Bool = false
    
    @Binding var text: String
    @Binding var isLocked: Bool

    let imageName: String
    
    var body: some View {
        HStack(spacing: GlobalConfigurations.normalSpacing) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 30, maxHeight: 30)

            if isLocked {
                SecureField("PasswordTextField", text: $text)
            } else {
                showValueTextField(if: showPassword)
            }
            
            Spacer()
            
            Text("\(text.count)/8")
                .foregroundStyle(.secondary)
                .opacity(text.count > 8 ? 0 : 1)
            
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
            .opacity(isLocked ? 0 : 1)
            
            Image(systemName: isLocked ? "lock.fill" : "lock.open.fill")
                .symbolEffect(.bounce, value: showEffect)
                .opacity(0.7)
                .frame(maxWidth: 30, maxHeight: 30)

        }
        .disabled(isLocked)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15)
                .stroke(style: StrokeStyle(lineWidth: 1))
        }
    }
    
    @ViewBuilder
    private func showValueTextField(if value: Bool) -> some View  {
        if value {
            TextField("TextField", text: $text)
        } else {
            SecureField("PasswordTextField", text: $text)
        }
    }
}

#Preview {
    @Previewable @State var text: String = "1234560"
    @Previewable @State var isLocked: Bool = false
    
    VStack {
        Button("Toggle") {
            isLocked.toggle()
        }
        
        TPLockPasswordTextField(text: $text, isLocked: $isLocked, imageName: "lock.fill")
            .padding(.horizontal)
    }
}
