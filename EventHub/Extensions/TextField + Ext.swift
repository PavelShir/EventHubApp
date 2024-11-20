//
//  TextField + Ext.swift
//  EventHub
//
//  Created by Павел Широкий on 20.11.2024.
//

import UIKit

extension UITextField {
    private func setLeftIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 16, y: 0, width: 24, height: 24))
        iconView.image = image.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = .lightText

        let iconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 64, height: 24))
        iconContainerView.addSubview(iconView)

        leftView = iconContainerView
        leftViewMode = .always

        // Добавляем целевой метод для изменения цвета иконки при изменении текста
        addAction(UIAction { [weak self] _ in self?.textDidChange() }, for: .editingChanged)
    }

    private func textDidChange() {
        guard let iconView = (leftView)?.subviews.first as? UIImageView else { return }

        // Изменяем цвет иконки в зависимости от наличия текста
        iconView.tintColor = text?.isEmpty == false ? UIColor(named: Constants.allColors.primaryButtonBlue) : .lightText
    }

    static func create(placeholder: String, icon: UIImage, isSecure: Bool = false) -> UITextField {
        let textField = UITextField()
        textField.setLeftIcon(icon)
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.lightText]
        )
        textField.textAlignment = .left
        textField.textColor = .darkText
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.layer.cornerRadius = 12
        textField.backgroundColor = .white
        textField.isSecureTextEntry = isSecure
        textField.autocapitalizationType = .none
        return textField
    }
}
