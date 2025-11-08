//
//  SettingsViewModel.swift
//  TicketPlace
//
//  Created by Caio Mandarino on 08/11/25.
//

import Combine
import Foundation

final class SettingsViewModel: ObservableObject {
    @Published var isLocked: Bool = true
    @Published var userInfo: UserResponse
    
    init(userInfo: UserResponse?) {
        if let userInfo {
            self.userInfo = userInfo
        } else {
            self.userInfo = UserResponse(id: UUID(), email: "", name: "", idGroup: 2)
        }
    }
}
