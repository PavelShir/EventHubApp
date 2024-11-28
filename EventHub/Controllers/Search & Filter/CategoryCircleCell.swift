//
//  CategoryCollectionCell.swift
//  EventHub
//
//  Created by Anna Melekhina on 27.11.2024.
//

import UIKit

class CategoryCircleCell: UICollectionViewCell {
    
    
    static let identifier = "CategoryCircleCell"
    
      let circleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        view.layer.shadowOpacity = 0.6
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 3
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
      let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor.systemGray
        
        return imageView
    }()
    
      let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AirbnbCerealApp", size: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(circleView)
        circleView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            circleView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            circleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
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
        iconView.image = UIImage(systemName: category.iconName)
        titleLabel.text = category.fullName
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                circleView.backgroundColor = UIColor(named: Constants.allColors.primaryBlue)
                circleView.layer.borderColor = UIColor.clear.cgColor
                iconView.tintColor = UIColor.white
                
            } else {
                circleView.backgroundColor = .white
                circleView.layer.borderColor = UIColor.systemGray.cgColor
                iconView.tintColor = UIColor.systemGray
                
            }
        }
    }
}


