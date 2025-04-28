//
//  LoginViewModel.swift
//  CompositionLayoutTest
//
//  Created by Abdul Qadar on 28/04/2025.
//

import Foundation
import Combine

@MainActor /// entire ViewModel runs on main thread automatically
class LoginViewModel {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isValid: Bool = false
    @Published var isLoggedIn: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        Publishers.CombineLatest($email, $password)
            .map { email, password in
                return self.validateEmail(email) && password.count >= 6
            }
            .assign(to: &$isValid)
    }

    func login() async {
        // Simulated API call delay
//        try? await Task.sleep(nanoseconds: 1_000_000_000)
        let token = UUID().uuidString
        AuthManager.shared.login(token: token)
        self.isLoggedIn = true // No need for DispatchQueue
    }

    private func validateEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
}
