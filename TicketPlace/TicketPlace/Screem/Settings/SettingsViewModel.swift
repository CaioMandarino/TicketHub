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
    @Published var oldPassword: String = ""
    @Published var newUsername: String
    @Published var newPassword: String = "*********"
    @Published var showAlert: Bool = false
    @Published var confirmationSave: Bool = false
    @Published var allUsers: [UserResponse] = []
    @Published var searchText: String = ""
    @Published var filteredUsers: [UserResponse] = []
    
    private let networkService: any NetworkServiceProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    var isFiltering: Bool {
        !searchText.isEmpty
    }
    
    var isAdmin: Bool {
        userInfo.idGroup == 1
    }
    
    init(userInfo: UserResponse?, networkService: some NetworkServiceProtocol) {
        self.networkService = networkService
        
        if let userInfo {
            self.userInfo = userInfo
            newUsername = userInfo.name
        } else {
            self.userInfo = UserResponse(id: UUID(), email: "", name: "", idGroup: 2)
            self.newUsername = ""
        }
        
        observableSearchTextDidChange()
    }
    
    func verifyPassword() async -> Bool {
        guard let _ = try? await networkService.login(email: userInfo.email, password: oldPassword) else {
            return false
        }
        
        return true
    }
    
    func editModeToggled() {
        newPassword = oldPassword
        isLocked.toggle()
    }
    
    func saveChanges() async {
        if newPassword != oldPassword {
            do {
                try await networkService.updatePassword(old: oldPassword, new: newPassword)
                oldPassword = newPassword
                confirmationSave = true
            } catch {
                showAlert = true
                return
            }
        }
        
        if userInfo.name != newUsername {
            do {
                try await networkService.updateUsername(new: newUsername)
                userInfo.name = newUsername
                confirmationSave = true
            } catch {
                showAlert = true
            }
        }
    }
    
    func getUsers() async {
        let elements = try? await networkService.getAllUsers(term: "@")
        self.allUsers = elements ?? []
    }
    
    private func observableSearchTextDidChange() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                guard let self else { return }
                
                let term = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

                if term.isEmpty {
                    filteredUsers = allUsers
                } else {
                    filteredUsers = allUsers.filter { user in
                        user.name.localizedCaseInsensitiveContains(term) || (user.email.localizedCaseInsensitiveContains(term))
                    }
                }
                
            }
            .store(in: &cancellables)
    }
    
    func deleteUser(_ user: UserResponse) {
        let userId = user.id
        
        // TODO: Faz o delete
    }
}
