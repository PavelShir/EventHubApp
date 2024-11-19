//
//  EventCell.swift
//  EventHub
//
//  Created by Anna Melekhina on 18.11.2024.
//

import UIKit

class EventCell: UITableViewCell {
    private let eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "darkBlue")
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    private let placeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 15
        contentView.layer.shadowColor = UIColor(named: "primaryBlue")?.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.clipsToBounds = false
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    private func setupLayout() {
        contentView.addSubview(eventImageView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(placeLabel)
        
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            eventImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            eventImageView.widthAnchor.constraint(equalToConstant: 80),
            eventImageView.heightAnchor.constraint(equalToConstant: 100),
            
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            dateLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            placeLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 10),
            placeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            placeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    func configure(with event: EventModel) {
        eventImageView.image = UIImage(named: event.imageName)
        dateLabel.text = event.date
        titleLabel.text = event.title
        placeLabel.text = event.place
    }
}

