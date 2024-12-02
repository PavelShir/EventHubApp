//
//  EditProfile.swift
//  EventHub
//
//  Created by Александр Гуркин on 18/11/24.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    private var user: UserModel?
    private var isExpanded = false
    
    var isGuestUser: Bool {
        return AuthManager.shared.currentUser == nil
    }
    //    MARK: - UI Elements
    let titleEditProfile = "Edit Profile"
    let imageSignOutButton = "signout"
    let imageEdit = "edit"
    var imageUser = "user"
    var nameUser = "Ashfak Sayem"
    var aboutMeContext = """
        Привет, я одинокий разработчик, который пишет код по ночам и после основной работы. Одинокий я не всегда, а только в моменты работы. Ухожу, так сказать, в себя. Ну а в другое время у меня конечно есть семья, мама, папа, жена и дети. А также я добавляю разные события в это приложение, чтобы всем стальным было веселее жить.
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
    
    
    private lazy var pictureEdit1: UIImageView = {
        let element = UIImageView()
        element.frame.size = CGSize(width: 22, height: 22)
        element.image = UIImage(named: imageEdit )
        element.contentMode = .scaleAspectFill
        element.isUserInteractionEnabled = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    private lazy var pictureEdit2: UIImageView = {
        let element = UIImageView()
        element.frame.size = CGSize(width: 22, height: 22)
        element.image = UIImage(named: imageEdit )
        element.contentMode = .scaleAspectFill
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
        textField.isUserInteractionEnabled = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var aboutMeLabel: UILabel = {
        let textField = UILabel()
        textField.text = "About Me"
        textField.textColor = UIColor(red: 51/255, green: 54/255, blue: 71/255, alpha: 1)
        textField.font = UIFont(name: "Inter-SemiBold", size: 16)
        textField.layer.masksToBounds = true
        textField.isUserInteractionEnabled = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    private lazy var aboutMeText: UITextView = {
        let textView = UITextView()
        textView.text = aboutMeContext
        textView.textColor = UIColor(red: 124/255, green: 130/255, blue: 161/255, alpha: 1)
        textView.font = UIFont(name: "Inter-Regular", size: 14)
        textView.sizeThatFits(CGSize(width: 120, height: 40))
        textView.layer.masksToBounds = true
        textView.isEditable = true
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
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
    
    private lazy var pictureUser: UIImageView = {
        let element = UIImageView()
        element.frame.size = CGSize(width: 96, height: 96)
        
        
        element.image = UIImage(named: imageUser)
        element.contentMode = .scaleAspectFill
        element.layer.cornerRadius = 48
        element.clipsToBounds = true
        element.layer.masksToBounds = true
        element.isUserInteractionEnabled = true
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
    
    @objc func signInTapped(_ sender: UIButton) {
        let vc = SingInController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //     MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        
        setupBackButton(action: #selector(backButtonTapped))
        
        super.viewDidLoad()
        aboutMeText.delegate = self
        
        view.backgroundColor = .white
        self.navigationItem.title = titleEditProfile
        configureUI()
        setupGestureRecognizer()
        setupTextFieldDelegates()
        
        loadProfileData()
        configureUI()
        
        // check user auth and configure wright button
        
        if isGuestUser {
            setupSignInButton()
        } else {
            loadUserData()
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    //     MARK: - UI Setup
    func configureUI() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(pictureUser)
        
        scrollView.addSubview(nameStackView)
        scrollView.addSubview(aboutMeStackView)
        
        aboutMeStackView.addArrangedSubview(aboutMeLabel)
        aboutMeStackView.addArrangedSubview(pictureEdit1)
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(pictureEdit2)
        
        scrollView.addSubview(aboutMeText)
        
        scrollView.addSubview(signOutButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19.5),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            
            pictureUser.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            pictureUser.widthAnchor.constraint(equalToConstant: 96),
            pictureUser.heightAnchor.constraint(equalToConstant: 96),
            pictureUser.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 30),
            nameStackView.topAnchor.constraint(equalTo: pictureUser.bottomAnchor, constant: 21),
            nameStackView.heightAnchor.constraint(equalToConstant: 22),
            
            
            aboutMeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            aboutMeStackView.topAnchor.constraint(equalTo: pictureUser.bottomAnchor, constant: 143),
            aboutMeStackView.heightAnchor.constraint(equalToConstant: 22),
            
            aboutMeText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            aboutMeText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            aboutMeText.topAnchor.constraint(equalTo: pictureUser.bottomAnchor, constant: 173),
            
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -49),
            
        ])
        
    }
    
    func setupTextFieldDelegates() {
        nameLabel.delegate = self
        aboutMeText.delegate = self
    }
    
    @objc func handleImageTap() {
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButton))
        navigationItem.leftBarButtonItem = cancelButton
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButton))
        navigationItem.rightBarButtonItem = doneButton
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleNameLabelTap() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButton))
        navigationItem.leftBarButtonItem = cancelButton
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButton))
        navigationItem.rightBarButtonItem = doneButton
        
    }
    
    @objc func handleEditName() {
        nameLabel.becomeFirstResponder()
    }

    @objc func handleEditAboutMe() {
        aboutMeText.becomeFirstResponder()
    }

    func setupGestureRecognizer() {
        let tapEditNameGesture = UITapGestureRecognizer(target: self, action: #selector(handleEditName))
        pictureEdit2.addGestureRecognizer(tapEditNameGesture)
        
        let tapEditAboutMeGesture = UITapGestureRecognizer(target: self, action: #selector(handleEditAboutMe))
        pictureEdit1.addGestureRecognizer(tapEditAboutMeGesture)
        
        let tapToDismissGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapToDismiss))
        view.addGestureRecognizer(tapToDismissGesture)
        tapToDismissGesture.cancelsTouchesInView = false
    }

    @objc func handleTapToDismiss() {
        view.endEditing(true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            pictureUser.image = editedImage
            UserDefaults.standard.set(editedImage.pngData(), forKey: "profileImage")
        } else if let originalImage = info[.originalImage] as? UIImage {
            pictureUser.image = originalImage
            UserDefaults.standard.set(originalImage.pngData(), forKey: "profileImage")
        }
        picker.dismiss(animated: true, completion: nil)
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
            aboutMeText.text = storedAddress
        }
    }
    
    @objc func saveProfileData() {
        if let name = nameLabel.text, let text = aboutMeText.text {
            UserDefaults.standard.set(name, forKey: "profileName")
            UserDefaults.standard.set(text, forKey: "profileAddress")
        }
    }
    
    @objc func cancelButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func doneButton() {
        saveProfileData()
        navigationController?.popViewController(animated: true)
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
    
    func setupSignInButton() {
        scrollView.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -49)
        ])
    }
}


extension EditProfileViewController {
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

extension EditProfileViewController {
    func textFieldDidEndEditing(_ textField: UITextField) {
        saveProfileData()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        saveProfileData()
    }
    
}
