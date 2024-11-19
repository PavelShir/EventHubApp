//
//  EditProfile.swift
//  EventHub
//
//  Created by Александр Гуркин on 18/11/24.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    let titleEditProfile = "Profile"

    
    //     MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        self.navigationItem.title = titleEditProfile
//        configureUI()
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = false
//        navigationItem.title = titleEditProfile
//
//        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07058823529, green: 0.05098039216, blue: 0.1490196078, alpha: 1), NSAttributedString.Key.font: UIFont.init(name: "SF Pro", size: 24)]
//
//    }
}

