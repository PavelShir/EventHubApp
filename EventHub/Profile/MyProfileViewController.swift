//
//  ProfileViewController.swift
//  EventHub
//
//  Created by Александр Гуркин on 18/11/24.
//

import UIKit

class MyProfileViewController: UIViewController {

    //    MARK: - UI Elements
    var action: Callback?
    let imageSignOutButton = "signout"
    let imageTermsConditionsButton = "angle-right"
    let imageLanguageButton = "angle-right"
    let userPicture = "pictureUser"
    let userName = "Dev P"
    let userMail = "dev@gmail.com"
    
    private lazy var backgroundViewColor: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var infoStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.spacing = 24
        element.distribution = .fill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    private lazy var verticalStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 0
        element.distribution = .fill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    private lazy var pictureUser: UIImageView = {
        let element = UIImageView()
        element.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        element.image = UIImage(named: userPicture)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var mainLabel: UILabel = {
        let element = UILabel()
        element.text = Texts.ProfileViewController.title
        element.textColor = UIColor(red: 51/255, green: 54/255, blue: 71/255, alpha: 1)
        element.font = UIFont(name: "Inter-SemiBold", size: 24)
        element.textAlignment = .left
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    private lazy var nameLabel: UILabel = {
        let element = UILabel()
        element.text = userName
        element.textColor = UIColor(red: 51/255, green: 54/255, blue: 71/255, alpha: 1)
        element.font = UIFont(name: "Inter-SemiBold", size: 16)
        element.textAlignment = .left
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var mailLabel: UILabel = {
        let element = UILabel()
        element.text = userMail
        element.textColor = UIColor(red: 124/255, green: 130/255, blue: 161/255, alpha: 1)
        element.font = UIFont(name: "Inter-Regular", size: 14)
        element.textAlignment = .left
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var signOutButton = UIButton(title: Texts.ProfileViewController.signOutButton, image: imageSignOutButton)
    private lazy var termsConditionsButton = UIButton(title: Texts.ProfileViewController.termsConditionsButton, image: imageTermsConditionsButton)
    private lazy var languageButton = UIButton(title: Texts.ProfileViewController.languageButton, image: imageLanguageButton)

    //     MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewsConstrains()
    }

    //     MARK: - UI Setup

    private func setupViewsConstrains() {
        
        view.backgroundView()
        view.addSubview(mainLabel)
        view.addSubview(infoStackView)
        infoStackView.addArrangedSubview(pictureUser)
        infoStackView.addArrangedSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(mailLabel)
        
        view.addButton(signOutButton)
        signOutButton.addTarget(self, action: #selector(signoutButtonTapped), for: .touchUpInside)
        view.addButton(termsConditionsButton)
        termsConditionsButton.addTarget(self, action: #selector(termsConditionsButtonTapped), for: .touchUpInside)
        view.addButton(languageButton)
        languageButton.addTarget(self, action: #selector(languageButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
        
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 72),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            infoStackView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 32),
            infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            nameLabel.topAnchor.constraint(equalTo: infoStackView.topAnchor, constant: 12),
            mailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            
            pictureUser.widthAnchor.constraint(equalToConstant: 72),
            pictureUser.heightAnchor.constraint(equalToConstant: 72),
            pictureUser.topAnchor.constraint(equalTo: infoStackView.topAnchor),
            pictureUser.leadingAnchor.constraint(equalTo: infoStackView.leadingAnchor),
            
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90),
            termsConditionsButton.bottomAnchor.constraint(equalTo: signOutButton.topAnchor, constant: -28),
            languageButton.topAnchor.constraint(equalTo: pictureUser.bottomAnchor, constant: 44),

        ])
    }

    // MARK: - Button Action
    
    @objc private func signoutButtonTapped() {
        if let action {
            action()
        } else {
            print("что то не так")
        }
    }
    
    @objc private func termsConditionsButtonTapped() {
        let nextViewController = TermsViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc private func languageButtonTapped() {
        let nextViewController = LanguageViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
 
}

