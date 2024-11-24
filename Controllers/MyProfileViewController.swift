//
//  ProfileViewController.swift
//  EventHub
//
//  Created by Александр Гуркин on 18/11/24.
//

import UIKit

class MyProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    //    MARK: - UI Elements
    
    let imageSignOutButton = "signout"
    let imageEdit = "edit"
    let titleNavigationBar = "Profile"
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
        scrollView.addSubview(editButton)
        
        scrollView.addSubview(nameStackView)
        
       
        
        
        scrollView.addSubview(aboutMeStackView)
        
        aboutMeStackView.addArrangedSubview(aboutMeLabel)
        aboutMeStackView.addArrangedSubview(pictureEdit1)
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(pictureEdit2)
        
        scrollView.addSubview(aboutMeText)
        
        scrollView.addSubview(signOutButton)
        
        
//        let backSaveButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditMode))
//                navigationItem.leftBarButtonItem = backSaveButton
//        // Set the title color to white for light mode or dark for dark mode
//        
//        navigationItem.leftBarButtonItem = backSaveButton
//        
        
        
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
            
            aboutMeText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            aboutMeText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            aboutMeText.topAnchor.constraint(equalTo: pictureUser.bottomAnchor, constant: 173),
            
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -49),
            
        ])
        
        updateUIForEditMode()
        
    }
    
    func setupTextFieldDelegates() {
        nameLabel.delegate = self
        aboutMeText.delegate = self
    }
    func updateUIForEditMode() {
        if isEditMode {
            // Enable text fields for editing
            pictureUser.isUserInteractionEnabled = true
            nameLabel.isEnabled = true
            aboutMeText.isEnabled = true
            
            // Change button title to "Save"
            editButton.configuration?.title = "Save"
           
            navigationItem.leftBarButtonItem?.title = "Save"
            // Add picture "edit" on UIElement
            pictureEdit1.image = UIImage(named: imageEdit)
            pictureEdit2.image = UIImage(named: imageEdit)
        } else {
            // Disable text fields
            pictureUser.isUserInteractionEnabled = false
            nameLabel.isEnabled = false
            aboutMeText.isEnabled = false
            
            // Change button title to "Edit"
            editButton.configuration?.title = "Edit Profile"
            navigationItem.leftBarButtonItem?.title = "Edit"
            
            //                navigationItem.rightBarButtonItem?.title = "Edit Profile"
            // delete picture "edit" on UIElement
            pictureEdit1.image = .emtyImage(with: CGSize(width: 22, height: 22))
            pictureEdit2.image = .emtyImage(with: CGSize(width: 22, height: 22))
        }
    }
    
    var changesMade = false
    var isEditMode = false
    
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
            aboutMeText.text = storedAddress
        }
        
    }
    
    
    @objc func saveProfileData() {
        if let name = nameLabel.text, let text = aboutMeText.text {
            UserDefaults.standard.set(name, forKey: "profileName")
            UserDefaults.standard.set(text, forKey: "profileAddress")
        }
    }
    
    
    @objc func tapEditButton() {
        self.navigationController?.pushViewController(EditProfileViewController(), animated: true)
    }
    
    @objc func tapSignOutButton() {
        self.navigationController?.pushViewController(OnboardingViewController(), animated: true)
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
