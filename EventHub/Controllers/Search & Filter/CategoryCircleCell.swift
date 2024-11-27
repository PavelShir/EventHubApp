//
//  CategoryCollectionCell.swift
//  EventHub
//
//  Created by Anna Melekhina on 27.11.2024.
//

import UIKit

class CategoryCircleCell: UICollectionViewCell {
    static let identifier = "CategoryCircleCell"

    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 60),
            iconView.heightAnchor.constraint(equalToConstant: 60),

            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
        ])

        contentView.layer.cornerRadius = 40
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor(named: Constants.allColors.primaryBlue)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with category: Category) {
        iconView.image = UIImage(named: category.iconName)
        titleLabel.text = category.fullName
    }
}
