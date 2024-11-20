//
//  SingInController.swift
//  EventHub
//
//  Created by Павел Широкий on 20.11.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


final class SingInController: UIViewController {

    // MARK: - Outlets

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Authorization.loginTitle
        label.font = UIFont.systemFont(
            ofSize: Constants.Authorization.fontSizeTitleLabel,
            weight: .bold
        )
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Authorization.loginDescription
        label.numberOfLines = 0
        label.font = UIFont.systemFont(
            ofSize: Constants.Authorization.fontSizeDescriptionLabel,
            weight: .regular
        )
        label.textColor = .lightText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField.create(
            placeholder: Constants.Authorization.placeholderEmail,
            icon: UIImage(named: "iconEmail")!
        )
        textField.text = "user@example.com"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField.create(
            placeholder: Constants.Authorization.placeholderPassword,
            icon: UIImage(named: "Lock")!,
            isSecure: true
        )
        textField.addAction(
            UIAction { [weak self] _
                in self?.setupPasswordObservers()
            },
            for: .editingChanged
        )
        textField.autocapitalizationType = .none
        textField.text = "123456" // TODO: Use temporary data for development. Remove this line before production.
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var togglePasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = .lightText
        button.addAction(
            UIAction { [weak self] _ in
                self?.togglePasswordVisibility()
            },
            for: .touchUpInside
        )
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.Authorization.signInButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: Constants.Authorization.fontSizeSign,
            weight: .bold
        )
        button.backgroundColor = UIColor(named: Constants.allColors.primaryButtonBlue)
        button.layer.cornerRadius = Constants.Authorization.cornerRadiusSignButton
        button.addAction(
            UIAction { [weak self] _ in
                self?.handleSignInButton()
            },
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = Constants.Authorization.spacingStackView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Authorization.signUpLabel
        label.font = UIFont.systemFont(
            ofSize: Constants.Authorization.fontSizeSign,
            weight: .regular
        )
        label.textColor = .lightText
        return label
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.Authorization.signUpButtonTitle, for: .normal)
        button.setTitleColor(.darkText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: Constants.Authorization.fontSizeSign,
            weight: .regular
        )
        button.addAction(
            UIAction { [weak self] _ in
                self?.handleSignUpButton()
            },
            for: .touchUpInside
        )
        return button
    }()

    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        setupView()
        setupHierarchy()
        setupLayout()
        setupPasswordObservers()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupView()
//        setupHierarchy()
//        setupLayout()
//        setupPasswordObservers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Setups

    private func setupView() {
        navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    private func setupHierarchy() {
        [
            titleLabel,
            descriptionLabel,
            emailTextField,
            passwordTextField,
            togglePasswordButton,
            signInButton,
            stackView
        ].forEach { view.addSubview($0) }
        [
            signUpLabel,
            signUpButton
        ].forEach { stackView.addArrangedSubview($0) }
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: Constants.Authorization.topMarginTitleLabel
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.Authorization.horizontalMarginTwenty
            ),
            descriptionLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Constants.Authorization.topMarginDescriptionLabel
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.Authorization.horizontalMarginTwenty
            ),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.Authorization.horizontalMarginTwenty
            ),
            emailTextField.topAnchor.constraint(
                equalTo: descriptionLabel.bottomAnchor,
                constant: Constants.Authorization.topMarginUpperTextField
            ),
            emailTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.Authorization.horizontalMarginTwenty
            ),
            emailTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.Authorization.horizontalMarginTwenty
            ),
            emailTextField.heightAnchor.constraint(
                equalToConstant: Constants.Authorization.heightTextField
            ),
            passwordTextField.topAnchor.constraint(
                equalTo: emailTextField.bottomAnchor,
                constant: Constants.Authorization.topMarginInteriorTextField
            ),
            passwordTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.Authorization.horizontalMarginTwenty
            ),
            passwordTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.Authorization.horizontalMarginTwenty
            ),
            passwordTextField.heightAnchor.constraint(
                equalToConstant: Constants.Authorization.heightTextField
            ),
            togglePasswordButton.centerYAnchor.constraint(
                equalTo: passwordTextField.centerYAnchor
            ),
            togglePasswordButton.trailingAnchor.constraint(
                equalTo: passwordTextField.trailingAnchor,
                constant: -Constants.Authorization.rightMarginToggleButton
            ),
            togglePasswordButton.heightAnchor.constraint(
                equalToConstant: Constants.Authorization.heightToggleButton
            ),
            signInButton.topAnchor.constraint(
                equalTo: passwordTextField.bottomAnchor,
                constant: Constants.Authorization.topMarginSignButton
            ),
            signInButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.Authorization.horizontalMarginTwenty
            ),
            signInButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.Authorization.horizontalMarginTwenty
            ),
            signInButton.heightAnchor.constraint(
                equalToConstant:  Constants.Authorization.heightSignButton
            ),
            stackView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            stackView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -Constants.Authorization.bottomMarginStackView
            )
        ])
    }

    private func setupPasswordObservers() {
        passwordTextField.addAction(UIAction { [weak self] _ in self?.passwordTextFieldDidChange() }, for: .editingChanged)
    }
}

// MARK: - Actions

private extension SingInController {
    func handleSignInButton() {
        guard
            let windowScene = view.window?.windowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate,
            let window = sceneDelegate.window
        else { return }

        guard
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
        else {
            showAlert(title: "Error", message: "Please fill out all fields.")
            return
        }

        AuthManager.shared.login(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                let vc = LaunchScreenViewController()
                let nc = UINavigationController(rootViewController: vc)
                window.rootViewController = nc
            case .failure(let error):
                self?.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }

    func handleSignUpButton() {
        let registrationViewController = SingUpController()
        registrationViewController.modalPresentationStyle = .fullScreen
        present(registrationViewController, animated: true, completion: nil)
    }

    func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        let image = passwordTextField.isSecureTextEntry ? "eye.slash": "eye"
        togglePasswordButton.setImage(UIImage(systemName: image), for: .normal)
    }

    func passwordTextFieldDidChange() {
        togglePasswordButton.isHidden = passwordTextField.text?.isEmpty ?? true
    }
}

// MARK: - Keyboard

extension SingInController {
    @objc
    private func hideKeyboard() {
        view.endEditing(true)
    }
}

extension SingInController {
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        present(alert, animated: true)
    }
}
