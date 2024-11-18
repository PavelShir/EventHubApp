//
//  UIButton+Extension.swift
//  NewsToday
//
//  Created by Vladimir Fibe on 26.10.2024.
//

import UIKit

extension UIButton {
    convenience init(name: String) {
        self.init()
        self.contentMode = .scaleAspectFit
        self.setImage(UIImage(named: name), for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false

    }
    static func createButton(
        title: String,
        uiFont: UIFont = UIFont(name:"Inter-SemiBold", size: 16)!,
        foregroundColor: UIColor = .white,
        backgroundColor: UIColor = UIColor(named: "purplePrimary")!,
        cornerRadius: CGFloat = 10,
        buttonHeight: CGFloat = 60,
        borderColor: UIColor = .clear,
        borderWidth: CGFloat = 0
    ) -> UIButton {
        let button = UIButton(type: .system)

        var config = UIButton.Configuration.filled()
                config.baseForegroundColor = foregroundColor
                config.baseBackgroundColor = backgroundColor

                
                config.title = title
                
               
                config.attributedTitle = AttributedString(title, attributes: AttributeContainer([.font: uiFont]))

                button.configuration = config
                button.layer.cornerRadius = cornerRadius
                button.layer.masksToBounds = true

                button.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true

                button.layer.borderColor = borderColor.cgColor
                button.layer.borderWidth = borderWidth

                return button
        }
}

let LocalizeUserDefaultKey = "LocalizeUserDefaultKey"
var LocalizeDefaultLanguage = "en"

extension UIView {
    func backgroundView() {
        let backgroundViewColor: UIView = {
            let element = UIView()
            element.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
        self.addSubview(backgroundViewColor)
        
        NSLayoutConstraint.activate([
            backgroundViewColor.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundViewColor.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundViewColor.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundViewColor.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    func addButton(_ button: UIButton) {
        self.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 56),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -19),
        ])
    }
}

extension UIButton {
    convenience init(title: String, image: String) {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.attributedTitle?.font = UIFont(name: "Inter-SemiBold", size: 16)
        configuration.titleAlignment = .leading
        configuration.baseForegroundColor = #colorLiteral(red: 0.4, green: 0.4235294118, blue: 0.5568627451, alpha: 1)
        configuration.image = UIImage(named: image)
        configuration.imagePlacement = .trailing
        configuration.background.cornerRadius = 12
        configuration.baseBackgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9568627451, blue: 0.9647058824, alpha: 1)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 16)
        
        self.init(configuration: configuration)
        self.contentHorizontalAlignment = .fill
        switch title {
        case "English", "Английский":
            self.isSelected = UserDefaults.standard.bool(forKey: "selectedLanguage")
            addEmtyImage()
        case "Russian", "Русский":
            self.isSelected = !UserDefaults.standard.bool(forKey: "selectedLanguage") // Берем из памяти, По умолчанию "Русский" не выбран
            addEmtyImage()
        default: print("error")
        }
        
        self.configurationUpdateHandler = updateButtonAppearance
        self.translatesAutoresizingMaskIntoConstraints = false
        
        
        func updateButtonAppearance(_ button: UIButton) {
            
            if button.isSelected {
                button.configuration?.baseForegroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.configuration?.baseBackgroundColor = #colorLiteral(red: 0.2784313725, green: 0.3529411765, blue: 0.8431372549, alpha: 1)
            } else {
                button.configuration?.baseForegroundColor = #colorLiteral(red: 0.4, green: 0.4235294118, blue: 0.5568627451, alpha: 1)
                button.configuration?.baseBackgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9568627451, blue: 0.9647058824, alpha: 1)
            }
        }
        func addEmtyImage() {
            if !self.isSelected {
                let size = CGSize(width: 24, height: 24)
                self.configuration?.image = UIImage.emtyImage(with: size)
            }
        }
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

extension String {
    func translated() -> String {
        if let path = Bundle.main.path(forResource: LocalizeDefaultLanguage, ofType: "lproj"), let bundle = Bundle(path: path) {
            return NSLocalizedString(self, bundle: bundle, comment: "")
        }
        
        return ""
    }
}

