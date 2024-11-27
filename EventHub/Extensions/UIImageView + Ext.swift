//
//  UILabel + Ext.swift
//  EventHub
//
//  Created by Павел Широкий on 21.11.2024.
//

import UIKit
import Kingfisher

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

extension UIImageView {
    
    func setImage(url: String) {
        self.kf.setImage(with: URL(string: url), placeholder: UIImage(named: "girlimage"))
    }
}
