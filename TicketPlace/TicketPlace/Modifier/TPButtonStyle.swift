//
//  TPButtonStyle.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 06/11/25.
//

import Foundation
import SwiftUI

struct TPButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .opacity(configuration.isPressed ? 0.5 : 1)
            .contentShape(Rectangle())
        
    }
}
