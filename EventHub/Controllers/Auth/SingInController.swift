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

    private let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "titleImage")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Authorization.loginDescription
        label.numberOfLines = 0
        label.font = UIFont.systemFont(
            ofSize: Constants.Authorization.fontSizeDescriptionLabel,
            weight: .bold
        )
        label.textColor = .black
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
        button.tintColor = .gray
        button.addAction(
            UIAction { [weak self] _ in
                self?.togglePasswordVisibility()
            },
            for: .touchUpInside
        )
        button.isHidden = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.Authorization.signInButtonTitle, for: .normal)
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
                self?.handleSignInButton()
            },
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["", ""])
        segmentedControl.backgroundColor = UIColor(named: Constants.allColors.primaryButtonBlue)
        segmentedControl.layer.cornerRadius = 19/2
        segmentedControl.layer.borderColor = UIColor(named: Constants.allColors.primaryButtonBlue)?.cgColor
        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.masksToBounds = true
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()

    private let rememberMeLabel: UILabel = {
        let label = UILabel()
        label.text = "Remember me"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot Password?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(SingInController.self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        return button
    }()
    
    private let stackViewPass: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        label.textColor = UIColor(named: Constants.allColors.darkText)
        return label
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.Authorization.signUpButtonTitle, for: .normal)
        button.setTitleColor(UIColor(named: Constants.allColors.primaryBlue), for: .normal)
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
        view.backgroundColor = UIColor(named: Constants.allColors.whiteBackground)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    private func setupHierarchy() {
        [
            titleImageView,
            descriptionLabel,
            emailTextField,
            passwordTextField,
            togglePasswordButton,
            signInButton,
            stackView,
            stackViewPass
        ].forEach { view.addSubview($0) }
        [
            segmentedControl,
            rememberMeLabel,
            forgotPasswordButton
        ].forEach { stackViewPass.addArrangedSubview($0) }
        [
            signUpLabel,
            signUpButton
        ].forEach { stackView.addArrangedSubview($0) }
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleImageView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: Constants.Authorization.topMarginTitleLabel
            ),
            titleImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.Authorization.horizontalMarginTwenty
            ),
            titleImageView.widthAnchor.constraint(equalToConstant: 140
            ),
            titleImageView.heightAnchor.constraint(equalToConstant: 140
            ),
            descriptionLabel.topAnchor.constraint(
                equalTo: titleImageView.bottomAnchor,
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
            stackViewPass.topAnchor.constraint(
                equalTo: passwordTextField.bottomAnchor,
                constant: Constants.Authorization.topMarginInteriorTextField
            ),
            stackViewPass.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.Authorization.horizontalMarginTwenty
            ),
            stackViewPass.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.Authorization.horizontalMarginTwenty
            ),
            stackViewPass.heightAnchor.constraint(
                equalToConstant: 30
            ),
            segmentedControl.heightAnchor.constraint(equalToConstant: 19
            ),
            segmentedControl.widthAnchor.constraint(equalToConstant: 36
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
                equalTo: stackViewPass.bottomAnchor,
                constant: Constants.Authorization.topMarginInteriorTextField
            ),
            signInButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.Authorization.horizontalMarginSingInButton
            ),
            signInButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.Authorization.horizontalMarginSingInButton
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
    
    @objc private func forgotPasswordTapped() {
        print("Forgot Password tapped")
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
