//
//  TPLockTextField.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 06/11/25.
//

import SwiftUI

struct TPLockTextField: View {
    @State private var showEffect: Bool = false
    
    @Binding var text: String
    @Binding var isLocked: Bool
    
    let imageName: String
    
    var body: some View {
        HStack(spacing: GlobalConfigurations.normalSpacing) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 30)

            if isLocked {
                Text(text)
                    .onTapGesture {
                        showEffect.toggle()
                    }
            } else {
                TextField("TextField", text: $text)
            }
            
            Spacer()
            
            Image(systemName: isLocked ? "lock.fill" : "lock.open.fill")
                .symbolEffect(.bounce, value: showEffect)
                .opacity(0.7)
                .frame(maxWidth: 30, maxHeight: 30)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15)
                .stroke(style: StrokeStyle(lineWidth: 1))
        }
    }
}

#Preview {
    @Previewable @State var text: String = "Caio"
    @Previewable @State var isLocked: Bool = false
    
    VStack {
        Button("Toggle") {
            isLocked.toggle()
        }
        
        TPLockTextField(text: $text, isLocked: $isLocked, imageName: "person.fill")
            .padding(.horizontal)
    }
}
