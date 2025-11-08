//
//  TPDateTimeSelection.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 07/11/25.
//

import SwiftUI

struct TPDateTimeSelection: View {
    @Binding var date: Date

    @State private var allowTimeSelection: Bool = false
    @State private var showTimePicker: Bool = true
    private let firstRectangleCornerRadius = RectangleCornerRadii(
        topLeading: 15,
        bottomLeading: 0,
        bottomTrailing: 0,
        topTrailing: 15
    )
    private let secondRectangleCornerRadius = RectangleCornerRadii(
        topLeading: 0,
        bottomLeading: 15,
        bottomTrailing: 15,
        topTrailing: 0
    )
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "calendar")
                DatePicker("Data", selection: $date, in: Date().addingTimeInterval(3600)..., displayedComponents: .date)
            }
            .padding()
            .background {
                UnevenRoundedRectangle(cornerRadii: firstRectangleCornerRadius)
                    .stroke(lineWidth: 1)
            }
            
            VStack {
                makeToggleTimeSelectionAction()
            }
            .padding()
            .background {
                UnevenRoundedRectangle(cornerRadii: secondRectangleCornerRadius)
                    .stroke(style: StrokeStyle(lineWidth: 1))
            }
        }
    }
    
    @ViewBuilder
    private func makeToggleTimeSelectionAction() -> some View {
        
        Toggle(isOn: $allowTimeSelection.animation()) {
            HStack {
                Image(systemName: "clock")
                VStack {
                    Text("Hora")
                    
                    if allowTimeSelection {
                        Text(date.formatted(date: .omitted, time: .shortened))
                            .foregroundStyle(.blue)
                            .onTapGesture {
                                withAnimation {
                                    showTimePicker.toggle()
                                }
                            }
                    }
                }
            }
        }
        .tint(.blue)
        
        if allowTimeSelection && showTimePicker {
            DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .transition(.identity)
        }
    }
}

#Preview {
    @Previewable @State var date: Date = Date()
    TPDateTimeSelection(date: $date)
}

