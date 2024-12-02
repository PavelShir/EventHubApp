//
//  EventCell.swift
//  EventHub
//
//  Created by Anna Melekhina on 18.11.2024.
//

import UIKit
import Kingfisher

class EventCell: UITableViewCell {
    
     let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor(named: "primaryBlue")?.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 5
        view.layer.masksToBounds = false
        return view
    }()
    
    var bookmarkIcon: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        button.tintColor = UIColor(named: "primaryRed")
        button.isHidden = true
        return button
    }()
    
      let eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
      let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "darkBlue")
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
      let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
      let placeLabel: UILabel = {
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
    
    func configure(with event: Event) {

        dateLabel.text = convertDate(date: event.startDate)
        titleLabel.text = event.title
        placeLabel.text = "Loading..."
        
        guard let placeId = event.placeId else {
            placeLabel.text = event.locationSlug
                return
            }
        
        loadPlaceFast(placeId: placeId) { [weak self] place in
                DispatchQueue.main.async {
                    if let place = place {
                        self?.placeLabel.text = (event.locationSlug ?? "") + ", " + (place.address ?? "")
                    } else {
                        self?.placeLabel.text = event.locationSlug
                    }
                }
            }
        
        
        if let urlToImage = event.images {
            eventImageView.setImage(url: urlToImage)
        } else {
            eventImageView.image = UIImage(named: "girlimage")
        }
        
    }
    
    private func convertDate(date: Int?) -> String {
        
        guard let date = date else {
                return "error invalid Date"
            }
            
            let timeInterval = TimeInterval(date)
            
            let dateObject = Date(timeIntervalSince1970: timeInterval)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE, MMM d, yy"
            return dateFormatter.string(from: dateObject)
    }
    
//private func didUpdateImage(from url: String) {
//    
//    guard let imageUrl = URL(string: url) else {
//        DispatchQueue.main.async {
//            self.eventImageView.image = UIImage(named: "girlimage")
//        }
//        return
//    }
//    
//    URLSession.shared.dataTask(with: imageUrl) { data, response, error in
//        if let data = data, let image = UIImage(data: data) {
//            DispatchQueue.main.async {
//                self.eventImageView.image = image
//            }
//        } else {
//            print(error?.localizedDescription ?? "error")
//            DispatchQueue.main.async {
//                self.eventImageView.image = UIImage(named: "girlimage")
//            }
//        }
//    }.resume()
//}
    
    
    
}

