//
//  CategoryCollectionCell.swift
//  EventHub
//
//  Created by Anna Melekhina on 27.11.2024.
//

import UIKit

class CategoryCircleCell: UICollectionViewCell {
    static let identifier = "CategoryCircleCell"

    // Синий круг для фона
    private let circleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30  // Круглый фон
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(named: Constants.allColors.primaryBlue) // Синий фон
        return view
    }()

    // Иконка категории
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // Текст (подпись) категории
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)  // Уменьшаем размер шрифта
        label.textColor = .black  // Черный текст
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Добавляем круг и текст в contentView
        contentView.addSubview(circleView)
                circleView.addSubview(iconView)  // Иконка теперь добавляется в circleView
                contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
                    // Окружность с иконкой
                    circleView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                    circleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),  // Отступ сверху
                    circleView.widthAnchor.constraint(equalToConstant: 60),  // Ширина круга
                    circleView.heightAnchor.constraint(equalToConstant: 60),  // Высота круга

                    iconView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
                    iconView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),  // Центрируем иконку внутри круга
                    iconView.widthAnchor.constraint(equalToConstant: 30),  // Размер иконки
                    iconView.heightAnchor.constraint(equalToConstant: 30),  // Размер иконки

                    // Текст под кругом
                    titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                    titleLabel.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 6),  // Отступ между иконкой и текстом
                    titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
                    titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
                ])
        // Сделаем контентВью прозрачным
        contentView.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with category: Category) {
        iconView.image = UIImage(named: "music.note" )
        titleLabel.text = category.fullName
    }

    // Обработка выделенной ячейки (изменение цвета фона при выделении)
    override var isSelected: Bool {
        didSet {
            if isSelected {
                circleView.backgroundColor = UIColor(named: Constants.allColors.primaryBlue)?.withAlphaComponent(0.8)  // Изменение фона при выделении
            } else {
                circleView.backgroundColor = UIColor(named: Constants.allColors.primaryBlue)  // Возвращаем стандартный синий цвет
            }
        }
    }
}


