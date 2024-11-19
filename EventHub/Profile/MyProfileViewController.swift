//
//  ProfileViewController.swift
//  EventHub
//
//  Created by Александр Гуркин on 18/11/24.
//

import UIKit

class MyProfileViewController: UIViewController {

    
    private lazy var editButton: UIButton = {
        let element = UIButton()
        element.setTitle("Edit", for: .normal)
        element.setTitleColor(.green, for: .normal)
        element.addTarget(self, action: #selector(tapEditButton), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    //    MARK: - UI Elements

//    let imageSignOutButton = "signout"
//    let imageLEditButton = "edit"
    let titleNavigationBar = "Profile"
//    var imageUser = "user"
//    var nameUser = "Ashfak Sayem"
   


    //     MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
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
        view.addSubview(editButton)
        
        NSLayoutConstraint.activate([
            editButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            editButton.heightAnchor.constraint(equalToConstant: 50),
            editButton.widthAnchor.constraint(equalToConstant: 154),
            
        ])
    }
    
    @objc func tapEditButton() {
        self.navigationController?.pushViewController(EditProfileViewController(), animated: true)
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
