//
//  ProfileViewController.swift
//  EventHub
//
//  Created by Александр Гуркин on 18/11/24.
//

import UIKit

class MyProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    //    MARK: - UI Elements
//    var action: Callback?
    let imageSignOutButton = "signout"
    let imageLEditButton = "edit"
    var imageUser = "user"
    var nameUser = "Ashfak Sayem"
   

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
        element.image = UIImage(named: imageUser)
        element.contentMode = .scaleAspectFill
        element.layer.cornerRadius = 48
        element.layer.masksToBounds = true
        element.isUserInteractionEnabled = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

//    private lazy var mainLabel: UILabel = {
//        let element = UILabel()
//        element.text = Texts.ProfileViewController.title
//        element.textColor = UIColor(red: 51/255, green: 54/255, blue: 71/255, alpha: 1)
//        element.font = UIFont(name: "Inter-SemiBold", size: 24)
//        element.textAlignment = .left
//        element.translatesAutoresizingMaskIntoConstraints = false
//        return element
//    }()
    
    
    private lazy var nameLabel: UITextField = {
        let textField = UITextField()
        textField.text = userName
        textField.textColor = UIColor(red: 51/255, green: 54/255, blue: 71/255, alpha: 1)
        textField.font = UIFont(name: "Inter-SemiBold", size: 16)
        textField.layer.masksToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var mailLabel: UITextField = {
        let textField = UITextField()
        textField.text = userMail
        textField.textColor = UIColor(red: 124/255, green: 130/255, blue: 161/255, alpha: 1)
        textField.font = UIFont(name: "Inter-Regular", size: 14)
        textField.layer.masksToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var isEditMode = false
    var changesMade = false
    
    private lazy var signOutButton = UIButton(title: Texts.ProfileViewController.signOutButton, image: imageSignOutButton)
    private lazy var termsConditionsButton = UIButton(title: Texts.ProfileViewController.termsConditionsButton, image: imageTermsConditionsButton)
    private lazy var languageButton = UIButton(title: Texts.ProfileViewController.languageButton, image: imageLanguageButton)

    //     MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewsConstrains()
        setupGestureRecognizer()
        setupTextFieldDelegates()
        loadProfileData()
   
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
        
        let editButton = UIBarButtonItem(title: "Edit Profile", style: .plain, target: self, action: #selector(toggleEditMode))
                navigationItem.rightBarButtonItem = editButton
        // Set the title color to white for light mode or dark for dark mode
        if traitCollection.userInterfaceStyle == .light {
            editButton.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        } else {
            editButton.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        }
        navigationItem.rightBarButtonItem = editButton
        
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
        
        updateUIForEditMode()
    }
    
    func setupTextFieldDelegates() {
        nameLabel.delegate = self
        mailLabel.delegate = self
        }
    func updateUIForEditMode() {
        if isEditMode {
        // Enable text fields for editing
            pictureUser.isUserInteractionEnabled = true
            nameLabel.isEnabled = true
            mailLabel.isEnabled = true
        // Change button title to "Save"
            navigationItem.rightBarButtonItem?.title = "Save"
        } else {
        // Disable text fields
            pictureUser.isUserInteractionEnabled = false
            nameLabel.isEnabled = false
            mailLabel.isEnabled = false
        // Change button title to "Edit"
            navigationItem.rightBarButtonItem?.title = "Edit Profile"
        }
    }
    
    @objc func toggleEditMode() {
           if changesMade {
               saveProfileData() // Save changes before toggling edit mode
           }
           isEditMode = !isEditMode
           updateUIForEditMode()
       }
    
    @objc func handleImageTap() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
        pictureUser.addGestureRecognizer(tapGesture)
            
        let tapToDismissGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapToDismiss))
        view.addGestureRecognizer(tapToDismissGesture)
        tapToDismissGesture.cancelsTouchesInView = false
    }
    
    @objc func handleTapToDismiss() {
        view.endEditing(true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage { // Use edited image if available
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
            mailLabel.text = storedAddress
        }
            
    }
    
    @objc func saveProfileData() {
        if let name = nameLabel.text, let address = mailLabel.text {
            UserDefaults.standard.set(name, forKey: "profileName")
            UserDefaults.standard.set(address, forKey: "profileAddress")
        }
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
