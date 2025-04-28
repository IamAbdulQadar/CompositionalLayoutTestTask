//
//  LoginViewController.swift
//  CompositionLayoutTest
//
//  Created by Abdul Qadar on 28/04/2025.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    private let viewModel = LoginViewModel()
    private var cancellables = Set<AnyCancellable>()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Log In"
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold) // Big title style
        label.textAlignment = .center
        return label
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.borderStyle = .roundedRect
        field.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return field
    }()

    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.borderStyle = .roundedRect
        field.isSecureTextEntry = true
        field.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return field
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.isEnabled = false
        button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.7)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .disabled)
        button.layer.cornerRadius = 8
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17) // 👈 Add this line
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            emailField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            emailField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),

            passwordField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),

            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }

    private func bindViewModel() {
        emailField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)

        viewModel.$isValid
            .receive(on: RunLoop.main)
            .assign(to: \UIButton.isEnabled, on: loginButton)
            .store(in: &cancellables)

        viewModel.$isLoggedIn
            .filter { $0 }
            .sink { [weak self] _ in
                let homeVC = HomeViewController()
                let navController = UINavigationController(rootViewController: homeVC)
                self?.view.window?.rootViewController = navController
            }
            .store(in: &cancellables)
    }

    @objc private func textChanged(_ sender: UITextField) {
        viewModel.email = emailField.text ?? ""
        viewModel.password = passwordField.text ?? ""
    }

    @objc private func handleLogin() {
        Task {
            await viewModel.login()
        }
    }
}
