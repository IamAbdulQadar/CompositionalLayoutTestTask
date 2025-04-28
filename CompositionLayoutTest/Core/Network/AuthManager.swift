//
//  AuthManager.swift
//  CompositionLayoutTest
//
//  Created by Abdul Qadar on 28/04/2025.
//

class AuthManager {
    static let shared = AuthManager()
    private let key = "auth_token"

    var isLoggedIn: Bool {
        return KeychainHelper.shared.read(key: key) != nil
    }

    func login(token: String) {
        KeychainHelper.shared.save(key: key, value: token)
    }

    func logout() {
        KeychainHelper.shared.delete(key: key)
    }
}
