//
//  ProfileViewController.swift
//  EventHub
//
//  Created by Александр Гуркин on 18/11/24.
//

import UIKit

class MyProfileViewController: UIViewController {
   
    //    MARK: - UI Elements

    let imageSignOutButton = "signout"
    let imageEditButton = "edit"
    let titleNavigationBar = "Profile"
    var imageUser = "user"
    var nameUser = "Ashfak Sayem"
   
    private let scrollView: UIScrollView = {
        let element = UIScrollView()
        element.backgroundColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
//    private let contentView: UIView = {
//        let element = UIView()
//        element.backgroundColor = .white
//        element.translatesAutoresizingMaskIntoConstraints = false
//        return element
//    }()
    
//    private lazy var contentStackView: UIStackView = {
//        let element = UIStackView()
//        element.axis = .vertical
////        element.spacing = 50
////        element.alignment = .center
//        element.distribution = .fill
//        element.isUserInteractionEnabled = true
//        element.translatesAutoresizingMaskIntoConstraints = false
//        return element
//    }()
    
    private lazy var contentStackView: UIView = {
        let element = UIView()
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
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var aboutMeLabel: UITextField = {
        let textField = UITextField()
        textField.text = "About Me"
        textField.textColor = UIColor(red: 51/255, green: 54/255, blue: 71/255, alpha: 1)
        textField.font = UIFont(name: "Inter-SemiBold", size: 16)
        textField.layer.masksToBounds = true
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
        configuration.image = UIImage(named: imageEditButton)
        configuration.imagePadding = 16
        configuration.background.cornerRadius = 10
        configuration.baseBackgroundColor = .white
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 13, leading: 19, bottom: 12, trailing: 18)
    
        let element = UIButton(configuration: configuration)
        element.contentHorizontalAlignment = .fill
        element.addTarget(self, action: #selector(tapEditButton), for: .touchUpInside)
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
        element.addTarget(self, action: #selector(tapSignOutButton), for: .touchUpInside)
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

   
    //     MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = titleNavigationBar
        configureUI()
    }
    

//    override func viewWillAppear(_ animated: Bool) {
//         super.viewWillAppear(animated)
//         navigationController?.navigationBar.isHidden = false
//         navigationItem.title = titleNavigationBar
//
//        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07058823529, green: 0.05098039216, blue: 0.1490196078, alpha: 1), NSAttributedString.Key.font: UIFont.init(name: "SF Pro", size: 24)]
//
//     }
    //     MARK: - UI Setup
    func configureUI() {
        
//        let scrollContentGuide = scrollView.contentLayoutGuide
//        let scrollFrameGuide = scrollView.frameLayoutGuide
        
        view.addSubview(scrollView)
        scrollView.addSubview(pictureUser)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(editButton)
        scrollView.addSubview(aboutMeLabel)
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
            
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: pictureUser.bottomAnchor, constant: 21),
            
            editButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            
            aboutMeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            aboutMeLabel.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 25),
            
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 20),
            
            
//            pictureUser.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
//            editButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            editButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            editButton.heightAnchor.constraint(equalToConstant: 50),
//            editButton.widthAnchor.constraint(equalToConstant: 154),
//
//            pictureUser.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            pictureUser.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 29),
//
            
        ])
    }
    
    @objc func tapEditButton() {
        self.navigationController?.pushViewController(EditProfileViewController(), animated: true)
    }
    
    @objc func tapSignOutButton() {
        self.navigationController?.pushViewController(OnboardingViewController(), animated: true)
    }
//    private func setupViewsConstrains() {
//
//        view.backgroundView()
//        view.addSubview(mainLabel)
//        view.addSubview(infoStackView)
//        infoStackView.addArrangedSubview(pictureUser)
//        infoStackView.addArrangedSubview(verticalStackView)
//
//        verticalStackView.addArrangedSubview(nameLabel)
//        verticalStackView.addArrangedSubview(mailLabel)
//
//        view.addButton(signOutButton)
//        signOutButton.addTarget(self, action: #selector(signoutButtonTapped), for: .touchUpInside)
//        view.addButton(termsConditionsButton)
//        termsConditionsButton.addTarget(self, action: #selector(termsConditionsButtonTapped), for: .touchUpInside)
//        view.addButton(languageButton)
//        languageButton.addTarget(self, action: #selector(languageButtonTapped), for: .touchUpInside)
//
//        let editButton = UIBarButtonItem(title: "Edit Profile", style: .plain, target: self, action: #selector(toggleEditMode))
//                navigationItem.rightBarButtonItem = editButton
//        // Set the title color to white for light mode or dark for dark mode
//        if traitCollection.userInterfaceStyle == .light {
//            editButton.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
//        } else {
//            editButton.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
//        }
//        navigationItem.rightBarButtonItem = editButton
//
//        NSLayoutConstraint.activate([
//
//            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 72),
//            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//
//            infoStackView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 32),
//            infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//
//            nameLabel.topAnchor.constraint(equalTo: infoStackView.topAnchor, constant: 12),
//            mailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
//
//            pictureUser.widthAnchor.constraint(equalToConstant: 72),
//            pictureUser.heightAnchor.constraint(equalToConstant: 72),
//            pictureUser.topAnchor.constraint(equalTo: infoStackView.topAnchor),
//            pictureUser.leadingAnchor.constraint(equalTo: infoStackView.leadingAnchor),
//
//            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90),
//            termsConditionsButton.bottomAnchor.constraint(equalTo: signOutButton.topAnchor, constant: -28),
//            languageButton.topAnchor.constraint(equalTo: pictureUser.bottomAnchor, constant: 44),
//
//        ])
//
//        updateUIForEditMode()
//    }
//
//    func setupTextFieldDelegates() {
//        nameLabel.delegate = self
//        mailLabel.delegate = self
//        }
//    func updateUIForEditMode() {
//        if isEditMode {
//        // Enable text fields for editing
//            pictureUser.isUserInteractionEnabled = true
//            nameLabel.isEnabled = true
//            mailLabel.isEnabled = true
//        // Change button title to "Save"
//            navigationItem.rightBarButtonItem?.title = "Save"
//        } else {
//        // Disable text fields
//            pictureUser.isUserInteractionEnabled = false
//            nameLabel.isEnabled = false
//            mailLabel.isEnabled = false
//        // Change button title to "Edit"
//            navigationItem.rightBarButtonItem?.title = "Edit Profile"
//        }
//    }
//
//    @objc func toggleEditMode() {
//           if changesMade {
//               saveProfileData() // Save changes before toggling edit mode
//           }
//           isEditMode = !isEditMode
//           updateUIForEditMode()
//       }
//
//    @objc func handleImageTap() {
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = .photoLibrary
//        imagePicker.allowsEditing = true
//        present(imagePicker, animated: true, completion: nil)
//    }
//
//    func setupGestureRecognizer() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
//        pictureUser.addGestureRecognizer(tapGesture)
//
//        let tapToDismissGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapToDismiss))
//        view.addGestureRecognizer(tapToDismissGesture)
//        tapToDismissGesture.cancelsTouchesInView = false
//    }
//
//    @objc func handleTapToDismiss() {
//        view.endEditing(true)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let editedImage = info[.editedImage] as? UIImage { // Use edited image if available
//            pictureUser.image = editedImage
//            UserDefaults.standard.set(editedImage.pngData(), forKey: "profileImage")
//        } else if let originalImage = info[.originalImage] as? UIImage {
//            pictureUser.image = originalImage
//            UserDefaults.standard.set(originalImage.pngData(), forKey: "profileImage")
//        }
//        picker.dismiss(animated: true, completion: nil)
//    }
//
//    func loadProfileData() {
//
//        if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
//            let image = UIImage(data: imageData) {
//            pictureUser.image = image
//        }
//
//        if let storedName = UserDefaults.standard.string(forKey: "profileName") {
//            nameLabel.text = storedName
//        }
//
//        if let storedAddress = UserDefaults.standard.string(forKey: "profileAddress") {
//            mailLabel.text = storedAddress
//        }
//
//    }
//
//    @objc func saveProfileData() {
//        if let name = nameLabel.text, let address = mailLabel.text {
//            UserDefaults.standard.set(name, forKey: "profileName")
//            UserDefaults.standard.set(address, forKey: "profileAddress")
//        }
//    }
//    // MARK: - Button Action
//
//    @objc private func signoutButtonTapped() {
//        if let action {
//            action()
//        } else {
//            print("что то не так")
//        }
//    }
//
//    @objc private func termsConditionsButtonTapped() {
//        let nextViewController = TermsViewController()
//        navigationController?.pushViewController(nextViewController, animated: true)
//    }
//
//    @objc private func languageButtonTapped() {
//        let nextViewController = LanguageViewController()
//        navigationController?.pushViewController(nextViewController, animated: true)
//    }
}

//extension UIButton {
//    convenience init(title: String, image: String) {
//        var configuration = UIButton.Configuration.filled()
//        configuration.title = title
//        configuration.attributedTitle?.font = UIFont(name: "Inter-SemiBold", size: 16)
//        configuration.titleAlignment = .leading
//        configuration.baseForegroundColor = #colorLiteral(red: 0.4, green: 0.4235294118, blue: 0.5568627451, alpha: 1)
//        configuration.image = UIImage(named: image)
//        configuration.imagePlacement = .trailing
//        configuration.background.cornerRadius = 12
//        configuration.baseBackgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9568627451, blue: 0.9647058824, alpha: 1)
//        configuration.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 16)
//
//        self.init(configuration: configuration)
//        self.contentHorizontalAlignment = .fill
//        switch title {
//        case "English", "Английский":
//            self.isSelected = UserDefaults.standard.bool(forKey: "selectedLanguage")
//            addEmtyImage()
//        case "Russian", "Русский":
//            self.isSelected = !UserDefaults.standard.bool(forKey: "selectedLanguage") // Берем из памяти, По умолчанию "Русский" не выбран
//            addEmtyImage()
//        default: print("error")
//        }
//
//        self.configurationUpdateHandler = updateButtonAppearance
//        self.translatesAutoresizingMaskIntoConstraints = false
//
//
//        func updateButtonAppearance(_ button: UIButton) {
//
//            if button.isSelected {
//                button.configuration?.baseForegroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//                button.configuration?.baseBackgroundColor = #colorLiteral(red: 0.2784313725, green: 0.3529411765, blue: 0.8431372549, alpha: 1)
//            } else {
//                button.configuration?.baseForegroundColor = #colorLiteral(red: 0.4, green: 0.4235294118, blue: 0.5568627451, alpha: 1)
//                button.configuration?.baseBackgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9568627451, blue: 0.9647058824, alpha: 1)
//            }
//        }
//        func addEmtyImage() {
//            if !self.isSelected {
//                let size = CGSize(width: 24, height: 24)
//                self.configuration?.image = UIImage.emtyImage(with: size)
//            }
//        }
//    }
//}
