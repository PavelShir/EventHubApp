//
//  ListCell.swift
//  EventHub
//
//  Created by Anna Melekhina on 29.11.2024.
//

import UIKit

class ListCell: EventCell {
    
    private let purpleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "primaryBlue")
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "READ"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let arrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.right.circle.fill"), for: .normal)
        button.tintColor = .white
        button.isUserInteractionEnabled = false
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCustomViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    
    private func setupCustomViews() {
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(purpleView)
        purpleView.addSubview(stackView)
        eventImageView.removeFromSuperview()
        dateLabel.removeFromSuperview()
        bookmarkIcon.removeFromSuperview()
        stackView.addArrangedSubview(label)  
               stackView.addArrangedSubview(arrowButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),

            // Ограничения для purpleView
            purpleView.widthAnchor.constraint(equalToConstant: 100),
            purpleView.heightAnchor.constraint(equalToConstant: 30),
            purpleView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            purpleView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15),

            // Ограничения для stackView внутри purpleView
            stackView.leadingAnchor.constraint(equalTo: purpleView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: purpleView.trailingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: purpleView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: purpleView.bottomAnchor)
            
        ])

    }

      func setCell (with item: Event) {

           titleLabel.text = item.title
       }
    
    
}
