//
//  UIButton + Ext.swift
//  EventHub
//
//  Created by Павел Широкий on 22.11.2024.
//

import UIKit

extension UIButton {
    func setRightIcon(_ image: UIImage, padding: CGFloat = 8) {
        let iconView = UIImageView(image: image.withRenderingMode(.alwaysOriginal))
        //iconView.tintColor = self.titleLabel?.textColor ?? .white
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(iconView)
        self.contentHorizontalAlignment = .center
        
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            iconView.widthAnchor.constraint(equalToConstant: 35),  // Ширина иконки
            iconView.heightAnchor.constraint(equalToConstant: 35) // Высота иконки
        ])
    }
    
    func setLeftButtontIcon(_ image: UIImage, padding: CGFloat = 8) {
        let iconView = UIImageView(image: image.withRenderingMode(.alwaysOriginal))
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(iconView)
        self.contentHorizontalAlignment = .center
        
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -padding),
            iconView.widthAnchor.constraint(equalToConstant: 35),  // Ширина иконки
            iconView.heightAnchor.constraint(equalToConstant: 35) // Высота иконки
        ])
    }
}

