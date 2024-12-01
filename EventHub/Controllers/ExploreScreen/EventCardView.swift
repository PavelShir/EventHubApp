//
//  EventCardView.swift
//  MyEventHub
//
//  Created by Дмирий Зядик on 22.11.2024.
//

import UIKit

class EventCardView: UIView {
    
//    var event: EventModel?
   
    
    private lazy var eventImage : UIImageView = {
//        let element = UIImageView(frame: CGRect(x: 9, y: 10, width: 218, height: 131))
        let element = UIImageView()
        element.layer.cornerRadius = 10
        element.clipsToBounds = true
        element.contentMode = .scaleAspectFill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
        
    func configure(with event: Event){
        eventImage.image = UIImage(named: event.images ?? "hands")
        titleLabel.text = event.title
        
        let ( mmm, d ) = MMMDayPair(date: event.startDate)
        
        dayLabel.text = d
        monthLabel.text = mmm.uppercased()
        
        titleLabel.text = event.title.capitalized
        
        
        guard let placeId = event.placeId else {
            address.text = event.locationSlug
                return
            }
        
     /*   loadPlace(placeId: placeId) { [weak self] place in
                DispatchQueue.main.async {
                    if let place = place {
                        self?.address.text = (event.locationSlug ?? "") + ", " + (place.address ?? "")
                    } else {
                        self?.address.text = event.locationSlug
                    }
                }
            }
        
       */
        if let urlToImage = event.images {
            eventImage.setImage(url: urlToImage)
        } else {
            eventImage.image = UIImage(named: "hands")
            
        }
    }
    
    private func MMMDayPair(date: Int?) -> (String, String) {
           
       guard let date = date else {
               return ("", "")
           }
           
           let timeInterval = TimeInterval(date)
           
           let dateObject = Date(timeIntervalSince1970: timeInterval)
           
            let dateFormatterMMM = DateFormatter()
            dateFormatterMMM.dateFormat = "MMM"
            
            let dateFormatterDay = DateFormatter()
            dateFormatterDay.dateFormat = "d"
        
           return (dateFormatterMMM.string(from: dateObject), dateFormatterDay.string(from: dateObject))
   }
    
    private lazy var dateView : UIView = {
//        let element = UIView(frame: CGRect(x: 17, y: 17, width: 45, height: 46.68))
        let element = UIView()
        element.layer.cornerRadius = 10
       // let stackView = UIStackView(axis: .vertical, distribution: .fillEqually, alignment: .center, spacing: 0, subViews: [dayLabel, monthLabel])
        element.addSubview(dayLabel)
        element.addSubview(monthLabel)
        element.backgroundColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var dayLabel : UILabel = {
        let element = UILabel()
        
        element.text = ""
//        element.font = .systemFont(ofSize: 17, weight: .bold)
        element.font =  UIFont(name: "AirbnbCerealApp", size: 17)
        
        element.textColor = UIColor(named: "primaryRed")
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var monthLabel : UILabel = {
        let element = UILabel()
        element.textColor = UIColor(named: "primaryRed")
        element.text = "JUNE"
//        element.font = .systemFont(ofSize: 11)
        element.font = UIFont(name: "AirbnbCerealApp", size: 9)
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var bookmarkView : UIView = {
//        let element = UIView(frame: CGRect(x: 187, y: 17, width: 30, height: 30))
        let element = UIView()
        element.layer.cornerRadius = 5
        element.addSubview(bookmarkImage)
        element.backgroundColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var bookmarkImage : UIImageView = {
//        let element = UIImageView(frame: CGRect(x: 195, y: 25, width: 14.1, height: 14))
        let element = UIImageView()
        element.image = UIImage(systemName: "bookmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 10))
        element.tintColor = UIColor(named: "primaryRed")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var titleLabel : UILabel = {
//        let element = UILabel(frame: CGRect(x: 16, y: 154, width: 198, height: 30))
        let element = UILabel()
        element.text = "International Band Music Concert"
        element.textColor = .black
//        element.font = .systemFont(ofSize: 18)
        element.font =  UIFont(name: "AirbnbCerealApp", size: 18)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var user1 : UIImageView = {
//        let element = UIImageView(frame: CGRect(x: 16, y: 187, width: 24, height: 24))
        let element = UIImageView()
        element.image = UIImage(named: "user1")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    private lazy var user2 : UIImageView = {
//        let element = UIImageView(frame: CGRect(x: 32, y: 187, width: 24, height: 24))
        let element = UIImageView()
        element.image = UIImage(named: "user2")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    private lazy var user3 : UIImageView = {
//        let element = UIImageView(frame: CGRect(x: 48, y: 187, width: 24, height: 24))
        let element = UIImageView()
        element.image = UIImage(named: "user3")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var userCount : UILabel = {
//        let element = UILabel(frame: CGRect(x: 82, y: 184, width: 79, height: 30))
        let element = UILabel()
        element.text = "+20 Going"
//        element.font = .systemFont(ofSize: 12)
        element.font =  UIFont(name: "AirbnbCerealApp", size: 12)
        element.textColor = UIColor(named: "primaryBlue")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var address : UILabel = {
//        let element = UILabel(frame: CGRect(x: 16, y: 221, width: 198, height: 30))
        let element = UILabel()
        element.text = "36 Guild Street London, UK"
//        element.font = .systemFont(ofSize: 13)
        element.font =  UIFont(name: "AirbnbCerealApp", size: 13)
        element.textColor = .gray
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var mapPinImage : UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "map-pin")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
 /*   private lazy var addressStack : UIStackView = {
//        let element = UIStackView(frame: CGRect(x: 16, y: 221, width: 198, height: 16))
        let element = UIStackView()
        element.axis = .horizontal
        element.spacing = 5
        element.distribution = .fill
        let mapPin = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 16))
        mapPin.image = UIImage(named: "map-pin")
        mapPin.frame.size = CGSize(width: 16, height: 16)
        mapPin.translatesAutoresizingMaskIntoConstraints = false
        element.addArrangedSubview(mapPin)
        element.addArrangedSubview(address)
        element.addArrangedSubview(UIView())
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()*/
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        addSubview(eventImage)
        addSubview(dateView)
        addSubview(bookmarkView)
        addSubview(bookmarkImage)
        addSubview(titleLabel)
        addSubview(user3)
        addSubview(user2)
        addSubview(user1)
        addSubview(userCount)
        addSubview(mapPinImage)
        addSubview(address)
        
        NSLayoutConstraint.activate([
            eventImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            eventImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 9),
           // eventImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            eventImage.heightAnchor.constraint(equalToConstant: 131),
            eventImage.widthAnchor.constraint(equalToConstant: 218),
            
            dateView.topAnchor.constraint(equalTo: eventImage.topAnchor, constant: 8),
            dateView.leadingAnchor.constraint(equalTo: eventImage.leadingAnchor, constant: 8),
            dateView.widthAnchor.constraint(equalToConstant: 45),
            dateView.heightAnchor.constraint(equalToConstant: 45),
            
            dayLabel.centerXAnchor.constraint(equalTo: dateView.centerXAnchor),
            
            monthLabel.centerXAnchor.constraint(equalTo: dateView.centerXAnchor),
            monthLabel.heightAnchor.constraint(equalToConstant: 16),
            monthLabel.bottomAnchor.constraint(equalTo: dateView.bottomAnchor, constant: -5),
            
            bookmarkView.topAnchor.constraint(equalTo: eventImage.topAnchor, constant: 8),
            bookmarkView.trailingAnchor.constraint(equalTo: eventImage.trailingAnchor, constant: -8),
            bookmarkView.widthAnchor.constraint(equalToConstant: 30),
            bookmarkView.heightAnchor.constraint(equalToConstant: 30),
            
            bookmarkImage.centerXAnchor.constraint(equalTo: bookmarkView.centerXAnchor),
            bookmarkImage.centerYAnchor.constraint(equalTo: bookmarkView.centerYAnchor),
            bookmarkImage.widthAnchor.constraint(equalToConstant: 14),
            bookmarkImage.heightAnchor.constraint(equalToConstant: 14),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 144),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.widthAnchor.constraint(equalToConstant: 198),
            
            user1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            user1.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 20),
            user1.widthAnchor.constraint(equalToConstant: 30),
            user1.heightAnchor.constraint(equalToConstant: 30),
            
            user2.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            user2.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 30),
            user2.widthAnchor.constraint(equalToConstant: 30),
            user2.heightAnchor.constraint(equalToConstant: 30),
            
            user3.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            user3.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 40),
            user3.widthAnchor.constraint(equalToConstant: 30),
            user3.heightAnchor.constraint(equalToConstant: 30),
            
            userCount.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            userCount.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 80),
//            userCount.widthAnchor.constraint(equalToConstant: 30),
            userCount.heightAnchor.constraint(equalToConstant: 30),
            
            mapPinImage.topAnchor.constraint(equalTo: user1.bottomAnchor, constant: 10),
            mapPinImage.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 20),
            mapPinImage.widthAnchor.constraint(equalToConstant: 16),
            mapPinImage.heightAnchor.constraint(equalToConstant: 16),
            
            address.topAnchor.constraint(equalTo: user1.bottomAnchor, constant: 10),
            address.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 50),
            address.widthAnchor.constraint(equalToConstant: 182),
            address.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
}
