//
//  MapCollection.swift
//  EventHub
//
//  Created by Anna Melekhina on 28.11.2024.
//

import UIKit

class MapCollectionCell: CategoryCircleCell {
    static let mapIdentifier = "CategoryMapCell"

    let hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func configure(with category: Category) {
        super.configure(with: category)
        
        contentView.backgroundColor = .clear
        circleView.backgroundColor = UIColor.white
        circleView.layer.cornerRadius = 20
        circleView.layer.borderWidth = 0.5

//        iconView.contentMode = .left
//        titleLabel.contentMode = .right

        titleLabel.tintColor = UIColor.black
        iconView.tintColor = UIColor(named: randomColorName!)
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(circleView)
        hStack.addArrangedSubview(iconView)
        hStack.addArrangedSubview(titleLabel)
        circleView.addSubview(hStack)
        
        NSLayoutConstraint.activate([
            circleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            circleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 220),
            circleView.heightAnchor.constraint(equalToConstant: 50),
            
            hStack.leadingAnchor.constraint(equalTo: circleView.leadingAnchor, constant: 50),
            hStack.trailingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: -50),
            hStack.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            
            iconView.widthAnchor.constraint(equalToConstant: 50),
            iconView.heightAnchor.constraint(equalToConstant: 50)
        ])
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let randomColorName = [
        "primaryGreen", "darkRed","primaryOrange","primaryLightBlue"
    ].randomElement()
    
}
    
    

