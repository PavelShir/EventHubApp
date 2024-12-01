//
//  ProfileViewController.swift
//  EventHub
//
//  Created by Александр Гуркин on 18/11/24.
//

import UIKit

class MyProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    private var user: UserModel?
    private var aboutMeTextHeightConstraint: NSLayoutConstraint!
    private var isExpanded = false
    
    var isGuestUser: Bool {
        return AuthManager.shared.currentUser == nil
    }
    
    //    MARK: - UI Elements
    
    let imageSignOutButton = "signout"
    let imageEdit = "edit"
    let titleNavigationBar = "Profile"
    var imageUser = "user"
    var nameUser = "Ashfak Sayem"
    var aboutMeContext = """
        Enjoy your favorite dishes and a lovely time with your friends and family. \
        Food from local food trucks will be available for purchase.
        """
    
    private let scrollView: UIScrollView = {
        let element = UIScrollView()
        element.backgroundColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var nameStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.spacing = 18
        element.alignment = .center
        element.distribution = .fill
                element.isUserInteractionEnabled = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var aboutMeStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.spacing = 8
        element.alignment = .center
        element.distribution = .fill
                element.isUserInteractionEnabled = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var nameLabel: UITextField = {
        let textField = UITextField()
        textField.text = nameUser
        textField.textColor = UIColor(red: 51/255, green: 54/255, blue: 71/255, alpha: 1)
        textField.font = UIFont(name: "Inter-SemiBold", size: 24)
        textField.layer.masksToBounds = true
        textField.isUserInteractionEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var aboutMeLabel: UILabel = {
        let textField = UILabel()
        textField.text = "About Me"
        textField.textColor = UIColor(red: 51/255, green: 54/255, blue: 71/255, alpha: 1)
        textField.font = UIFont(name: "Inter-SemiBold", size: 16)
        textField.layer.masksToBounds = true
        textField.isUserInteractionEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    private lazy var aboutMeTextView: UITextView = {
        let textField = UITextView()
        textField.text = aboutMeContext
        textField.textColor = UIColor(red: 124/255, green: 130/255, blue: 161/255, alpha: 1)
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.backgroundColor = .clear
        textField.isEditable = false
        textField.isScrollEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var editButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Edit Profile"
        configuration.attributedTitle?.font = UIFont(name: "Inter-SemiBold", size: 16)
        configuration.titleAlignment = .leading
        configuration.baseForegroundColor = #colorLiteral(red: 0.3170624971, green: 0.4148232043, blue: 1, alpha: 1)
        configuration.background.strokeWidth = 1.5
        configuration.background.strokeColor = #colorLiteral(red: 0.3170624971, green: 0.4148232043, blue: 1, alpha: 1)
        configuration.image = UIImage(named: imageEdit)
        configuration.imagePadding = 16
        configuration.background.cornerRadius = 10
        configuration.baseBackgroundColor = .white
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 13, leading: 19, bottom: 12, trailing: 18)
        
        let element = UIButton(configuration: configuration)
        element.contentHorizontalAlignment = .fill
        element.addTarget(self, action: #selector(tapEditButton), for: .touchUpInside)
        element.isUserInteractionEnabled = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var signOutButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Sign Out"
        configuration.attributedTitle?.font = UIFont(name: "Inter-SemiBold", size: 16)
        configuration.titleAlignment = .leading
        configuration.baseForegroundColor = .black
        
        configuration.image = UIImage(named: imageSignOutButton)
        configuration.imagePadding = 16
        
        configuration.baseBackgroundColor = .white
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 13, leading: 19, bottom: 12, trailing: 18)
        
        let element = UIButton(configuration: configuration)
        element.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var signInButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Sign In"
        configuration.attributedTitle?.font = UIFont(name: "Inter-SemiBold", size: 16)
        configuration.titleAlignment = .leading
        configuration.baseForegroundColor = .black
        
        configuration.image = UIImage(named: imageSignOutButton)
        configuration.imagePadding = 16
        
        configuration.baseBackgroundColor = .white
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 13, leading: 19, bottom: 12, trailing: 18)
        
        let element = UIButton(configuration: configuration)
        element.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var pictureUser: UIImageView = {
        let element = UIImageView()
        element.frame.size = CGSize(width: 96, height: 96)
        if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
           let image = UIImage(data: imageData) {
            element.image = image
        } else {
            element.image = UIImage(named: imageUser)
        }
//        element.image = UIImage(named: imageUser)
        element.contentMode = .scaleAspectFill
        element.layer.cornerRadius = 48
        element.clipsToBounds = true
        element.layer.masksToBounds = true
        element.isUserInteractionEnabled = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var readMoreButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Read More", for: .normal)
            button.setTitleColor(.blue, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.addTarget(self, action: #selector(toggleReadMore), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
    
    //     MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = titleNavigationBar
        loadProfileData()
        configureUI()
        
        // check user auth and configure wright button
        
        if isGuestUser {
            setupSignInButton()
        } else {
            loadUserData()
        }
    }
    
    @objc private func toggleReadMore() {
        aboutMeTextView.layoutIfNeeded()
        isExpanded.toggle()
        
        let targetHeight: CGFloat
            if isExpanded {
                targetHeight = aboutMeTextView.contentSize.height
            } else {
                targetHeight = 50
            }
            aboutMeTextHeightConstraint.constant = targetHeight
        
        let buttonTitle = isExpanded ? "Read Less" : "Read More"
        readMoreButton.setTitle(buttonTitle, for: .normal)
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }

    func loadProfileData() {
        
        if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
           let image = UIImage(data: imageData) {
            pictureUser.image = image
        }
        
        if let storedName = UserDefaults.standard.string(forKey: "profileName") {
            nameLabel.text = storedName
        }
        
        if let storedAddress = UserDefaults.standard.string(forKey: "profileAddress") {
            aboutMeTextView.text = storedAddress
        }
    }
    
    //     MARK: - UI Setup
    func configureUI() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(pictureUser)
        scrollView.addSubview(editButton)
        scrollView.addSubview(nameStackView)
        scrollView.addSubview(aboutMeStackView)
        aboutMeStackView.addArrangedSubview(aboutMeLabel)
        nameStackView.addArrangedSubview(nameLabel)
        scrollView.addSubview(aboutMeTextView)
        scrollView.addSubview(readMoreButton)
        scrollView.addSubview(signOutButton)
        
        aboutMeTextHeightConstraint = aboutMeTextView.heightAnchor.constraint(equalToConstant: 50)
        aboutMeTextHeightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19.5),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            
            pictureUser.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            pictureUser.widthAnchor.constraint(equalToConstant: 96),
            pictureUser.heightAnchor.constraint(equalToConstant: 96),
            pictureUser.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameStackView.topAnchor.constraint(equalTo: pictureUser.bottomAnchor, constant: 21),
            nameStackView.heightAnchor.constraint(equalToConstant: 22),
            
            editButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editButton.topAnchor.constraint(equalTo: pictureUser.bottomAnchor, constant: 68),
            
            aboutMeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            aboutMeStackView.topAnchor.constraint(equalTo: pictureUser.bottomAnchor, constant: 143),
            aboutMeStackView.heightAnchor.constraint(equalToConstant: 22),
            
            aboutMeTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            aboutMeTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            aboutMeTextView.topAnchor.constraint(equalTo: pictureUser.bottomAnchor, constant: 173),
            
            readMoreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            readMoreButton.topAnchor.constraint(equalTo: aboutMeTextView.bottomAnchor, constant: 10),
            
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -49),
            
        ])
        loadProfileData()
    }
    
    @objc func signInTapped(_ sender: UIButton) {
        let vc = SingInController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func signOutTapped(_ sender: UIButton) {
            guard
                let windowScene = view.window?.windowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate,
                let window = sceneDelegate.window
            else { return }

            AuthManager.shared.logout { [weak self] result in
                switch result {
                case .success:
                    let vc = OnboardingViewController()
                    let nc = UINavigationController(rootViewController: vc)
                    window.rootViewController = nc
                case .failure(let error):
                    self?.showAlert(title: "Ошибка", message: error.localizedDescription)
                }
            }
        }
    
    @objc func tapEditButton() {
        self.navigationController?.pushViewController(EditProfileViewController(), animated: true)
    }
    
    func setupSignInButton() {
        scrollView.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -49)
        ])
    }
}


extension UIImage {
    static func emtyImage(with size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}


extension MyProfileViewController {
    private func loadUserData() {
        guard let user = AuthManager.shared.currentUser else { return }
        
        FirestoreManager.shared.getUserData(userID: user.uid) { [weak self] result in
            switch result {
            case .success(let userData):
                if let username = userData["username"] as? String {
                    self?.nameUser = username
                    self?.nameLabel.text = username
                }
                
            case .failure(let error):
                self?.showAlert(title: "Ошибка", message: error.localizedDescription)
            }
        }
    }
}
