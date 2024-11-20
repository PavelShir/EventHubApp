//
//  EventCustomCell.swift
//  EventHub
//
//  Created by Anna Melekhina on 20.11.2024.
//

import UIKit

class EventCustomCell: UITableViewCell {
    
    private let eventImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.contentMode = .scaleAspectFill
           imageView.layer.cornerRadius = 10
           imageView.clipsToBounds = true
           return imageView
       }()
       
       private let dateLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
           label.textColor = UIColor.systemBlue
           return label
       }()
       
       private let titleLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.boldSystemFont(ofSize: 16)
           label.numberOfLines = 2
           return label
       }()
       
       private let locationLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 14)
           label.textColor = UIColor.gray
           return label
       }()
       
       private let locationIcon: UIImageView = {
           let imageView = UIImageView()
           imageView.image = UIImage(systemName: "mappin")
           imageView.tintColor = UIColor.gray
           return imageView
       }()
       
       // MARK: - Init
       
       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: "EventCustomCell")
           contentView.backgroundColor = .systemBackground
           contentView.layer.cornerRadius = 15
           contentView.layer.shadowColor = UIColor(named: "primaryBlue")?.cgColor
           contentView.layer.shadowOpacity = 0.4
           contentView.layer.shadowRadius = 5
//           contentView.layer.borderWidth = 0.3
//           contentView.layer.borderColor = UIColor(named: "primaryBlue")?.cgColor
           contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
           contentView.clipsToBounds = false
           
           setupUI()
       }
       
       required init?(coder: NSCoder) {
           fatalError("error")
       }
       
       // MARK: - UI Setup
       
       private func setupUI() {
            contentView.addSubview(eventImageView)
           contentView.addSubview(dateLabel)
           contentView.addSubview(titleLabel)
           contentView.addSubview(locationIcon)
           contentView.addSubview(locationLabel)
           
            eventImageView.translatesAutoresizingMaskIntoConstraints = false
           dateLabel.translatesAutoresizingMaskIntoConstraints = false
           titleLabel.translatesAutoresizingMaskIntoConstraints = false
           locationIcon.translatesAutoresizingMaskIntoConstraints = false
           locationLabel.translatesAutoresizingMaskIntoConstraints = false
           
            NSLayoutConstraint.activate([
                eventImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
               eventImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
               eventImageView.widthAnchor.constraint(equalToConstant: 50),
               eventImageView.heightAnchor.constraint(equalToConstant: 50),
               
                dateLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 16),
               dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
               dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
               
                titleLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 16),
               titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
               titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
               
                locationIcon.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 16),
               locationIcon.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
               locationIcon.widthAnchor.constraint(equalToConstant: 16),
               locationIcon.heightAnchor.constraint(equalToConstant: 16),
               
                locationLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 4),
               locationLabel.centerYAnchor.constraint(equalTo: locationIcon.centerYAnchor),
               locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
               locationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
           ])
       }
       
       // MARK: - Configuration
       
    func configure(with event: EventModel) {
        eventImageView.image = UIImage(named: event.imageName)
        dateLabel.text = convertDate(date: event.date)
        titleLabel.text = event.title
        locationLabel.text = event.place
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

    

