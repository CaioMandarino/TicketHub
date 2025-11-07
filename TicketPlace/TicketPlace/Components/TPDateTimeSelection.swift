//
//  TPDateTimeSelection.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 07/11/25.
//

import SwiftUI

struct TPDateTimeSelection: View {
    @State private var allowTimeSelection: Bool = false
    @Binding var date: Date
    
    let firstRectangleCornerRadius = RectangleCornerRadii(
        topLeading: 15,
        bottomLeading: 0,
        bottomTrailing: 0,
        topTrailing: 15
    )
    
    let secondRectangleCornerRadius = RectangleCornerRadii(
        topLeading: 0,
        bottomLeading: 15,
        bottomTrailing: 15,
        topTrailing: 0
    )
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "calendar")
                DatePicker("Data", selection: $date, displayedComponents: .date)
            }
            .padding()
            .background {
                UnevenRoundedRectangle(cornerRadii: firstRectangleCornerRadius)
                    .stroke(lineWidth: 1)
            }
            
            HStack {
                Image(systemName: "clock")
        
                Toggle("Hora", isOn: $allowTimeSelection)
                    .tint(.blue)
            }
            .padding()
            .background {
                UnevenRoundedRectangle(cornerRadii: secondRectangleCornerRadius)
                    .stroke(style: StrokeStyle(lineWidth: 1))
            }
        }
    }
}

#Preview {
    @Previewable @State var date: Date = Date()
    TPDateTimeSelection(date: $date)
}

