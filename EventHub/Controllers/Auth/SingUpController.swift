//
//  SingUpController.swift
//  EventHub
//
//  Created by Павел Широкий on 20.11.2024.
//

import UIKit

final class SingUpController: UIViewController {

    // MARK: - Outlets

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Authorization.registerDescription
        label.numberOfLines = 0
        label.font = UIFont.systemFont(
            ofSize: Constants.Authorization.fontSizeDescriptionLabel,
            weight: .regular
        )
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let usernameTextField: UITextField = {
        let textField = UITextField.create(
            placeholder: Constants.Authorization.placeholderName,
            icon: UIImage(named: "Profile")!
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField.create(
            placeholder: Constants.Authorization.placeholderEmail,
            icon: UIImage(named: "iconEmail")!
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField.create(
            placeholder: Constants.Authorization.placeholderPassword,
            icon: UIImage(named: "Lock")!,
            isSecure: true
        )
        textField.textContentType = .oneTimeCode
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var togglePasswordButton1: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(PasswordVisibility), for: .touchUpInside)
        button.isHidden = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func PasswordVisibility() {
        togglePasswordVisibility(for: passwordTextField, button: togglePasswordButton1)
    }

    private let repeatPasswordTextField: UITextField = {
        let textField = UITextField.create(
            placeholder: Constants.Authorization.placeholderRepeatPassword,
            icon: UIImage(named: "Lock")!,
            isSecure: true
        )
        textField.textContentType = .oneTimeCode
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var togglePasswordButton2: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(toggleRepeatPasswordVisibility), for: .touchUpInside)
        button.isHidden = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func toggleRepeatPasswordVisibility() {
        togglePasswordVisibility(for: repeatPasswordTextField, button: togglePasswordButton2)
    }

    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.Authorization.signUpButtonTitle, for: .normal)
        button.setRightIcon(UIImage(named: "arrowButton")!, padding: 8)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: Constants.Authorization.fontSizeSign,
            weight: .bold
        )
        button.backgroundColor = UIColor(named: Constants.allColors.primaryButtonBlue)
        button.layer.cornerRadius = Constants.Authorization.cornerRadiusSignButton
        button.addAction(
            UIAction { [weak self] _ in
                self?.handleSignUpButton()
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

    private let signInLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Authorization.signInLabel
        label.font = UIFont.systemFont(
            ofSize: Constants.Authorization.fontSizeSign,
            weight: .regular
        )
        label.textColor = .black
        return label
    }()

    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.Authorization.signInButtonTitle, for: .normal)
        button.setTitleColor(UIColor(named: Constants.allColors.primaryBlue), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: Constants.Authorization.fontSizeSign,
            weight: .regular
        )
        button.addAction(
            UIAction { [weak self] _ in
                self?.handleSignInButton()
            },
            for: .touchUpInside
        )
        return button
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackButton(action: #selector(backButtonTapped))
        
        self.title = "Sing up"
        let textAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 24, weight: .bold),
                .foregroundColor: UIColor.black
            ]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        setupView()
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setups
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func togglePasswordVisibility(for textField: UITextField, button: UIButton) {
        
        textField.isSecureTextEntry.toggle()
        let image = textField.isSecureTextEntry ? "eye.slash": "eye"
        button.setImage(UIImage(systemName: image), for: .normal)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    private func setupHierarchy() {
        [
            descriptionLabel,
            usernameTextField,
            emailTextField,
            passwordTextField,
            repeatPasswordTextField,
            togglePasswordButton1,
            togglePasswordButton2,
            signUpButton,
            stackView
        ].forEach { view.addSubview($0) }
        [
            signInLabel,
            signInButton
        ].forEach { stackView.addArrangedSubview($0) }
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: Constants.Authorization.topMarginTitleLabel
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.Authorization.horizontalMarginTwenty
            ),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.Authorization.horizontalMarginTwenty
            ),
            usernameTextField.topAnchor.constraint(
                equalTo: descriptionLabel.bottomAnchor,
                constant: Constants.Authorization.topMarginUpperTextField
            ),
            usernameTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.Authorization.horizontalMarginTwenty
            ),
            usernameTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.Authorization.horizontalMarginTwenty
            ),
            usernameTextField.heightAnchor.constraint(
                equalToConstant: Constants.Authorization.heightTextField
            ),
            emailTextField.topAnchor.constraint(
                equalTo: usernameTextField.bottomAnchor,
                constant: Constants.Authorization.topMarginInteriorTextField
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
            repeatPasswordTextField.topAnchor.constraint(
                equalTo: passwordTextField.bottomAnchor,
                constant: Constants.Authorization.horizontalMarginTwenty
            ),
            repeatPasswordTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.Authorization.horizontalMarginTwenty
            ),
            repeatPasswordTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.Authorization.horizontalMarginTwenty
            ),
            repeatPasswordTextField.heightAnchor.constraint(
                equalToConstant: Constants.Authorization.heightTextField
            ),
            togglePasswordButton1.centerYAnchor.constraint(
                equalTo: passwordTextField.centerYAnchor
            ),
            togglePasswordButton1.trailingAnchor.constraint(
                equalTo: passwordTextField.trailingAnchor,
                constant: -Constants.Authorization.rightMarginToggleButton
            ),
            togglePasswordButton1.heightAnchor.constraint(
                equalToConstant: Constants.Authorization.heightToggleButton
            ),
            togglePasswordButton2.centerYAnchor.constraint(
                equalTo: repeatPasswordTextField.centerYAnchor
            ),
            togglePasswordButton2.trailingAnchor.constraint(
                equalTo: repeatPasswordTextField.trailingAnchor,
                constant: -Constants.Authorization.rightMarginToggleButton
            ),
            togglePasswordButton2.heightAnchor.constraint(
                equalToConstant: Constants.Authorization.heightToggleButton
            ),
            signUpButton.topAnchor.constraint(
                equalTo: repeatPasswordTextField.bottomAnchor,
                constant: Constants.Authorization.topMarginSignButton
            ),
            signUpButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.Authorization.horizontalMarginTwenty
            ),
            signUpButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.Authorization.horizontalMarginTwenty
            ),
            signUpButton.heightAnchor.constraint(
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
}

// MARK: - Actions

private extension SingUpController {
    func handleSignUpButton() {
        guard
            let username = usernameTextField.text, !username.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let repeatPassword = repeatPasswordTextField.text, !repeatPassword.isEmpty
        else {
            showAlert(title: "Error", message: "Please fill out all fields.")
            return
        }

        guard password == repeatPassword else {
            showAlert(title: "Error", message: "The passwords do not match.")
            return
        }

        // Показать индикатор загрузки
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()

        AuthManager.shared.register(email: email, password: password, username: username) { [weak self] result in
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()

                switch result {
                case .success:
                    self?.showAlert(title: "Success", message: "Account created successfully!") {
                        self?.handleSignInButton()
                    }
                case .failure(let error):
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }

    func handleSignInButton() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Keyboard

extension SingUpController {
    @objc
    private func hideKeyboard() {
        view.endEditing(true)
    }
}
