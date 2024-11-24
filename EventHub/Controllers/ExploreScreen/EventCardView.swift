//
//  EventCardView.swift
//  MyEventHub
//
//  Created by Дмирий Зядик on 22.11.2024.
//

import UIKit

class EventCardView: UIView {
    
//    var event: EventModel?
   
    
    private lazy var image : UIImageView = {
        let element = UIImageView(frame: CGRect(x: 9, y: 10, width: 218, height: 131))
        //element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
        
    func configure(event: EventModel){
        image.image = UIImage(named: event.imageName)
        titleLabel.text = event.title
        address.text = event.place
        dayLabel.text = "12"
        monthLabel.text = "JAN"
        
    }
    
    private lazy var dateView : UIView = {
        let element = UIView(frame: CGRect(x: 17, y: 17, width: 45, height: 46.68))
        element.layer.cornerRadius = 10
        let stackView = UIStackView(axis: .vertical, distribution: .fillEqually, alignment: .center, spacing: 0, subViews: [dayLabel, monthLabel])
        element.addSubview(stackView)
        element.backgroundColor = .white
        return element
    }()
    
    private lazy var dayLabel : UILabel = {
        let element = UILabel()
        
        element.text = "10"
        element.font = .systemFont(ofSize: 17, weight: .bold)
        element.textColor = UIColor(named: "primaryRed")
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var monthLabel : UILabel = {
        let element = UILabel()
        element.textColor = UIColor(named: "primaryRed")
        element.text = "JUNE"
        element.font = .systemFont(ofSize: 11)
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var bookmarkView : UIView = {
        let element = UIView(frame: CGRect(x: 187, y: 17, width: 30, height: 30))
        element.layer.cornerRadius = 5
        element.addSubview(bookmarkImage)
        element.backgroundColor = .white
        
        return element
    }()
    
    private lazy var bookmarkImage : UIImageView = {
        let element = UIImageView(frame: CGRect(x: 195, y: 25, width: 14.1, height: 14))
        element.image = UIImage(systemName: "bookmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 10))
        element.tintColor = UIColor(named: "primaryRed")
//        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var titleLabel : UILabel = {
        let element = UILabel(frame: CGRect(x: 16, y: 154, width: 198, height: 30))
        element.text = "International Band Music Concert"
        element.font = .systemFont(ofSize: 18)
        return element
    }()
    
    private lazy var user1 : UIImageView = {
        let element = UIImageView(frame: CGRect(x: 16, y: 187, width: 24, height: 24))
        element.image = UIImage(named: "user1")
        return element
    }()
    private lazy var user2 : UIImageView = {
        let element = UIImageView(frame: CGRect(x: 32, y: 187, width: 24, height: 24))
        element.image = UIImage(named: "user2")
        return element
    }()
    private lazy var user3 : UIImageView = {
        let element = UIImageView(frame: CGRect(x: 48, y: 187, width: 24, height: 24))
        element.image = UIImage(named: "user3")
        return element
    }()
    
    private lazy var userCount : UILabel = {
        let element = UILabel(frame: CGRect(x: 82, y: 184, width: 79, height: 30))
        element.text = "+20 Going"
        element.font = .systemFont(ofSize: 12)
        element.textColor = UIColor(named: "primaryBlue")
//        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var address : UILabel = {
        let element = UILabel(frame: CGRect(x: 16, y: 221, width: 198, height: 30))
        element.text = "36 Guild Street London, UK"
        element.font = .systemFont(ofSize: 13)
        element.textColor = .gray
//        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var addressStack : UIStackView = {
        let element = UIStackView(frame: CGRect(x: 16, y: 221, width: 198, height: 16))
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
//        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
//    init(event: EventModel) {
//        self.event = event
//        super.init(frame: .zero)
//    }
    
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
        
        addSubview(image)
        addSubview(dateView)
        addSubview(bookmarkView)
        addSubview(bookmarkImage)
        addSubview(titleLabel)
        addSubview(user3)
        addSubview(user2)
        addSubview(user1)
        addSubview(userCount)
        addSubview(addressStack)
        
        NSLayoutConstraint.activate([
            dayLabel.centerXAnchor.constraint(equalTo: dateView.centerXAnchor),
          
          /*  image.topAnchor.constraint(equalTo: self.topAnchor, constant: 9),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 9),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),            
            image.heightAnchor.constraint(equalToConstant: 131),*/
        ])
    }
    
}
