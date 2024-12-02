//
//  ForgotPasswordControler.swift
//  EventHub
//
//  Created by Павел Широкий on 01.12.2024.
//

import UIKit

class ForgotPasswordController: UIViewController {
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Authorization.forgotPassDescription
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField.create(
            placeholder: Constants.Authorization.placeholderEmail,
            icon: UIImage(named: "iconEmail")!
        )
        textField.placeholder = "Enter your email"
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SEND", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: Constants.Authorization.fontSizeSign,
            weight: .bold
        )
        button.setRightIcon(UIImage(named: "arrowButton")!, padding: 8)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: Constants.allColors.primaryButtonBlue)
        button.layer.cornerRadius = Constants.Authorization.cornerRadiusSignButton
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupBackButton(color: .black, action: #selector(backButtonTapped))
        title = "Reset Password"
        let textAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 24, weight: .bold),
                .foregroundColor: UIColor.black
            ]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        setupViews()
        
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupViews() {
        view.addSubview(descriptionLabel)
        view.addSubview(emailTextField)
        view.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: Constants.Authorization.topMarginTitleLabel + 100
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
            sendButton.topAnchor.constraint(
                equalTo: emailTextField.bottomAnchor,
                constant: Constants.Authorization.topMarginInteriorTextField
            ),
            sendButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.Authorization.horizontalMarginSingInButton
            ),
            sendButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.Authorization.horizontalMarginSingInButton
            ),
            sendButton.heightAnchor.constraint(
                equalToConstant:  Constants.Authorization.heightSignButton
            ),
        ])
        
        
    }
    
    @objc private func sendButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty else {
            showError("Please enter a valid email address.")
            return
        }
        askForPasswordReset(email: email)
    }
    
    private func askForPasswordReset(email: String) {
        PasswordResetManager.shared.sendPasswordReset(to: email) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.showSuccess("A password reset link has been sent to your email.")
                case .failure(let error):
                    self.showError(error.localizedDescription)
                }
            }
        }
    }
    
    private func showSuccess(_ message: String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

