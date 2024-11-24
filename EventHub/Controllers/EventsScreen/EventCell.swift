//
//  EventCell.swift
//  EventHub
//
//  Created by Anna Melekhina on 18.11.2024.
//

import UIKit

class EventCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor(named: "primaryBlue")?.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 5
        view.layer.masksToBounds = false
        return view
    }()
    
    var bookmarkIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "bookmark.fill")
        icon.tintColor = UIColor(named: "primaryRed")
        icon.isHidden = true
        return icon
    }()
    
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
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
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
        
        setupLayout()
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupLayout() {
        containerView.addSubview(eventImageView)
        containerView.addSubview(dateLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(placeLabel)
        containerView.addSubview(bookmarkIcon)
        
        
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        bookmarkIcon.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            eventImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            eventImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            eventImageView.widthAnchor.constraint(equalToConstant: 80),
            eventImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            
            dateLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            dateLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 10),
            //            dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            bookmarkIcon.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            //            bookmarkIcon.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 10),
            bookmarkIcon.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            placeLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 10),
            placeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            placeLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -11)
        ])
    }
    
    func configure(with event: EventModel) {
        eventImageView.image = UIImage(named: event.imageName)
        dateLabel.text = convertDate(date: event.date)
        titleLabel.text = event.title
        placeLabel.text = event.place
    }
    
    private func convertDate(date: String) -> String {
        
        guard let timeInterval = Double(date) else {
            return "error invalid Date"
        }
        
        let date = Date(timeIntervalSince1970: timeInterval)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMM d • h:mm a"
        
        return formatter.string(from: date)
    }
    
    
}
