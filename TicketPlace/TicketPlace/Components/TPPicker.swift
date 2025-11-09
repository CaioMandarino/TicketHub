//
//  TPPicker.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 07/11/25.
//

import SwiftUI

struct TPPicker<T: CaseIterable & Hashable>: View {
    @Binding private var selection: T?
    private let title: String
    private let noneText: String
    private let includeNone: Bool
    private let label: (T) -> String

    init(
        _ title: String,
        selection: Binding<T?>,
        noneText: String = "Selecione…",
        includeNone: Bool = true,
        label: @escaping (T) -> String = { String(describing: $0) }
    ) {
        self._selection = selection
        self.title = title
        self.noneText = noneText
        self.includeNone = includeNone
        self.label = label
    }

    var body: some View {
        HStack(spacing: GlobalConfigurations.normalSpacing) {
            Text(title)
            Spacer()
        
            Picker(title, selection: $selection) {
                if includeNone {
                    Text(noneText).tag(nil as T?)
                    Divider()
                }
                
                ForEach(Array(T.allCases), id: \.self) { element in
                    Text(label(element)).tag(element as T?)
                }
            } currentValueLabel: {
                Text(selection.map(label) ?? noneText)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            .tint(Color.primary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 1)
        )
    }
}

extension TPPicker where T: RawRepresentable, T.RawValue == String {
    init(
        _ title: String,
        selection: Binding<T?>,
        noneText: String = "Selecione…",
        includeNone: Bool = false
    ) {
        self.init(title, selection: selection, noneText: noneText, includeNone: includeNone) { $0.rawValue }
    }
}

#Preview {
    @Previewable @State var selection: ReminderEnum? = nil
    TPPicker("Lembrete", selection: $selection, noneText: "Nunca", includeNone: true)
        .padding(.horizontal)
}

