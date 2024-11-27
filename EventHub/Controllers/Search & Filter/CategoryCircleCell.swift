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
//        view.layer.shadowOffset = 1
//        view.layer.shadowOpacity = 0.2
        view.backgroundColor = UIColor(named: Constants.allColors.primaryBlue) // Синий фон
        return view
    }()

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
                circleView.addSubview(iconView)
                contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
                    circleView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                    circleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
                    circleView.widthAnchor.constraint(equalToConstant: 60),
                    circleView.heightAnchor.constraint(equalToConstant: 60),

                    iconView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
                    iconView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
                    iconView.widthAnchor.constraint(equalToConstant: 30),
                    iconView.heightAnchor.constraint(equalToConstant: 30),

                    titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                    titleLabel.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 6),
                    titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
                    titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
                ])
        contentView.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with category: Category) {
        iconView.image = UIImage(named: "music.note")
        titleLabel.text = category.fullName
    }

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


