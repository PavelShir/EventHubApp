//
//  EditProfile.swift
//  EventHub
//
//  Created by Александр Гуркин on 18/11/24.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
        
        //    MARK: - UI Elements
        let titleEditProfile = "Edit Profile"
        let imageSignOutButton = "signout"
        let imageEdit = "edit"
        var imageUser = "user"
        var nameUser = "Ashfak Sayem"
        var aboutMeContext = "dspogjiosgerjkfnjskxnvclksajfioewshdkfndsklxz.,jvcnwkjdsghfjcmwodsljfcndsjkg,mhcmwls.x,fjckdsmfcnmklds,fkdslnfkds,fjcmelwds,fjmcwlds,gnfcjkedsbgvc jdks"
        
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
        
        
        private lazy var aboutMeText: UITextField = {
            let textField = UITextField()
            textField.text = aboutMeContext
            textField.textColor = UIColor(red: 124/255, green: 130/255, blue: 161/255, alpha: 1)
            textField.font = UIFont(name: "Inter-Regular", size: 14)
            textField.sizeThatFits(CGSize(width: 120, height: 40))
            textField.layer.masksToBounds = true
            textField.isUserInteractionEnabled = true
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
        
    private lazy var backButton: UIButton = {
        let element = UIButton()
        element.setImage(UIImage(named: "back"), for: .normal)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let customBackButton = UIBarButtonItem(customView: element)
        navigationItem.leftBarButtonItem = customBackButton
        return element
    }()
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
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
            self.navigationItem.title = titleEditProfile
            loadProfileData()
            configureUI()
            setupGestureRecognizer()
            setupTextFieldDelegates()
            
        }
        
        //     MARK: - UI Setup
        func configureUI() {
            
            //        let scrollContentGuide = scrollView.contentLayoutGuide
            //        let scrollFrameGuide = scrollView.frameLayoutGuide
            
            view.addSubview(scrollView)
            view.addSubview(backButton)
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
            
//            updateUIForEditMode()
            
        }
        
        func setupTextFieldDelegates() {
            nameLabel.delegate = self
            aboutMeText.delegate = self
        }
//        func updateUIForEditMode() {
//            pictureUser.isUserInteractionEnabled = true
//            nameLabel.isEnabled = true
//            aboutMeText.isEnabled = true
////
////            if isEditMode {
////                // Enable text fields for editing
////                pictureUser.isUserInteractionEnabled = true
////                nameLabel.isEnabled = true
////                aboutMeText.isEnabled = true
////
////                // Change button title to "Save"
////
////
////            } else {
////                // Disable text fields
////                pictureUser.isUserInteractionEnabled = false
////                nameLabel.isEnabled = false
////                aboutMeText.isEnabled = false
////
////            }
//        }
//
//        var changesMade = true
//        var isEditMode = true
//
//        @objc func toggleEditMode() {
//            if changesMade {
//                saveProfileData() // Save changes before toggling edit mode
//            }
//            isEditMode = !isEditMode
//            updateUIForEditMode()
//        }
        
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
        
        func setupGestureRecognizer() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
            pictureUser.addGestureRecognizer(tapGesture)
            
            let tapNameLabelGesture = UITapGestureRecognizer(target: self, action: #selector(handleNameLabelTap))
            nameLabel.addGestureRecognizer(tapNameLabelGesture)
            let tapaboutMeTextGesture = UITapGestureRecognizer(target: self, action: #selector(handleNameLabelTap))
            nameLabel.addGestureRecognizer(tapNameLabelGesture)
            aboutMeText.addGestureRecognizer(tapaboutMeTextGesture)
            
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
        
//        if #available(iOS 16.0, *) {
//            navigationItem.leftBarButtonItem?.isHidden
//        } else {
//            // Fallback on earlier versions
//        }
//
//        if #available(iOS 16.0, *) {
//            navigationItem.rightBarButtonItem?.isHidden
//        } else {
//            // Fallback on earlier versions
//        }
        navigationController?.popViewController(animated: true)
//        self.navigationController?.pushViewController(EditProfileViewController(), animated: true)
    }
    
    @objc func doneButton() {
        saveProfileData()
        navigationController?.popViewController(animated: true)
//        self.navigationController?.pushViewController(EditProfileViewController(), animated: true)
    }
        
        @objc func tapSignOutButton() {
            self.navigationController?.pushViewController(OnboardingViewController(), animated: true)
        }
    }


