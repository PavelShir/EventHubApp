//
//  BarBackButton + Ext.swift
//  EventHub
//
//  Created by Павел Широкий on 29.11.2024.
//

import UIKit

extension UIViewController {
    
    func setupBackButton(imageName: String = "back", action: Selector) {
        let backButton = UIButton()
        backButton.setImage(UIImage(named: imageName), for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: action, for: .touchUpInside)
        
        let customBackButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = customBackButton
    }
}

