//
//  UILabel + Ext.swift
//  EventHub
//
//  Created by Павел Широкий on 21.11.2024.
//

import UIKit

extension UIImageView {
    static func makeImage(named imageName: String = "image", cornerRadius: CGFloat) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
}
