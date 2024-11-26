//
//  ExploreDetailsVC.swift
//  MyEventHub
//
//  Created by Дмирий Зядик on 22.11.2024.
//

import Foundation
import UIKit
import SwiftUI

class EventDetailsViewController: UIViewController {
    
    private lazy var headerView : EventDetailHeader = {
        let element = EventDetailHeader()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let bodyLabel: UILabel = {
            let view = UILabel()
        view.numberOfLines = 2
            return view
        }()
    
    private let contentTextView: UITextView = {
            let content = UITextView()
            content.isScrollEnabled = false
            return content
        }()
    
    private let scrollView: UIScrollView = {
            let scroll = UIScrollView()
            //scroll.backgroundColor = .brown
            return scroll
        }()
    let stackView = UIStackView()
    
    // MARK: - calendar Row UI
    private lazy var calendarStackView : UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
       // element.distribution = .fill
        element.spacing = 23
        [ calendarView, colStackView, UIView() ].forEach { v in
                    element.addArrangedSubview(v)
                }
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var colStackView : UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        
        element.distribution = .equalCentering
        [ captionLabel, descriptionLabel ].forEach { v in
                    element.addArrangedSubview(v)
                }
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let captionLabel: UILabel = {
            let view = UILabel()
            view.text = "14 Decenber, 2021"
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    private let descriptionLabel: UILabel = {
            let view = UILabel()
            view.text = "Tuesday, 4:00PM - 9:00PM"
        view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    private lazy var calendarView : UIView = {
        let element = UIView()
        element.layer.cornerRadius = 15
        element.addSubview(calendarImage)
        element.backgroundColor = .gray.withAlphaComponent(0.2)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var calendarImage : UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "calendar")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    func configureCalendarRow(){
        calendarImage.image = UIImage(named: "calendar")
        captionLocationLabel.text = "14 Decenber, 202122"
        descriptionLabel.text = "Tuesday, 4:00PM - 9:00PM"
    }
    
    // MARK: - Location Row UI
    
    private lazy var locationStackView : UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
       // element.distribution = .fill
        element.spacing = 23
        [ locationView, colLocationStackView, UIView() ].forEach { v in
                    element.addArrangedSubview(v)
                }
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var colLocationStackView : UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        
        element.distribution = .equalCentering
        [ captionLocationLabel, descriptionLocationLabel ].forEach { v in
                    element.addArrangedSubview(v)
                }
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let captionLocationLabel: UILabel = {
            let view = UILabel()
            view.text = "14 Decenber, 2021"
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    private let descriptionLocationLabel: UILabel = {
            let view = UILabel()
            view.text = "Tuesday, 4:00PM - 9:00PM"
        view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    private lazy var locationView : UIView = {
        let element = UIView()
        element.layer.cornerRadius = 15
        element.addSubview(locationImage)
        element.backgroundColor = .gray.withAlphaComponent(0.2)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var locationImage : UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "location")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    func configureLocationRow(){
        locationImage.image = UIImage(named: "location")
        captionLocationLabel.text = "Gala Convention Center"
        descriptionLocationLabel.text = "36 Guild Street London, UK"
    }
    
    // MARK: - Organizator Row UI
    
    private lazy var organizatorStackView : UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
       // element.distribution = .fill
        element.spacing = 23
        [ organizatorImage, colOrganizatorStackView, UIView() ].forEach { v in
                    element.addArrangedSubview(v)
                }
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var colOrganizatorStackView : UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        
        element.distribution = .equalCentering
        [ captionOrganizatorLabel, descriptionOrganizatorLabel ].forEach { v in
                    element.addArrangedSubview(v)
                }
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let captionOrganizatorLabel: UILabel = {
            let view = UILabel()
            view.text = "14 Decenber, 2021"
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    private let descriptionOrganizatorLabel: UILabel = {
            let view = UILabel()
            view.text = "Tuesday, 4:00PM - 9:00PM"
        view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
   
    
    private lazy var organizatorImage : UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "organizator")
        element.layer.masksToBounds = true
        element.layer.cornerRadius = 15
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    func configureOrganizatorRow(){
        organizatorImage.image = UIImage(named: "organizator")
        captionOrganizatorLabel.text = "Ashfak Sayem"
        descriptionOrganizatorLabel.text = "Organizer"
    }
    
    private lazy var aboutLabel : UILabel = {
        let element = UILabel()
        element.text = "About Event"
        element.font = .systemFont(ofSize: 18)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
   // let exploreDetailRow = ExploreDetailRow()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setupConstrains()
    }
    
    func setView(){
        bodyLabel.text = "International Band Music Concert"
        bodyLabel.font = .systemFont(ofSize: 35)
        contentTextView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        
        //contentTextView.backgroundColor = .yellow
        contentTextView.font = .systemFont(ofSize: 20.0, weight: .light)
        
        stackView.axis = .vertical
        stackView.spacing = 21
        
       // exploreDetailRow.translatesAutoresizingMaskIntoConstraints = false
      //  exploreDetailRow.backgroundColor = .green
       // exploreDetailRow.configure()
        configureCalendarRow()
        configureLocationRow()
        configureOrganizatorRow()
        
        [ bodyLabel, calendarStackView, locationStackView, organizatorStackView, aboutLabel, contentTextView].forEach { v in
                    stackView.addArrangedSubview(v)
                }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        view.backgroundColor = .white
        view.addSubview(headerView)
        
    }
    
    // MARK: - Action
    
   
}

extension EventDetailsViewController {
    
    
    private func setupConstrains(){
        let g = view.safeAreaLayoutGuide
        let cg = scrollView.contentLayoutGuide
        let fg = scrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 50.0),
            scrollView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
            scrollView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
            scrollView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: -20.0),
           
            stackView.topAnchor.constraint(equalTo: cg.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: cg.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: cg.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: cg.bottomAnchor, constant: 0),
           
            stackView.widthAnchor.constraint(equalTo: fg.widthAnchor, constant: -20.0),
        
            calendarStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 4),
            calendarStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
         
            colStackView.heightAnchor.constraint(equalToConstant: 54),
            
            calendarView.heightAnchor.constraint(equalToConstant: 48),
            calendarView.widthAnchor.constraint(equalToConstant: 48),
            
            calendarImage.heightAnchor.constraint(equalToConstant: 30),
            calendarImage.widthAnchor.constraint(equalToConstant: 30),
            calendarImage.centerXAnchor.constraint(equalTo: calendarView.centerXAnchor),
            calendarImage.centerYAnchor.constraint(equalTo: calendarView.centerYAnchor),
            
            locationStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 4),
            locationStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            colLocationStackView.heightAnchor.constraint(equalToConstant: 54),
            
            locationView.heightAnchor.constraint(equalToConstant: 48),
            locationView.widthAnchor.constraint(equalToConstant: 48),
            
            locationImage.heightAnchor.constraint(equalToConstant: 30),
            locationImage.widthAnchor.constraint(equalToConstant: 30),
            locationImage.centerXAnchor.constraint(equalTo: locationView.centerXAnchor),
            locationImage.centerYAnchor.constraint(equalTo: locationView.centerYAnchor),
            
            organizatorStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 4),
            organizatorStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            colOrganizatorStackView.heightAnchor.constraint(equalToConstant: 54),
                    
            organizatorImage.heightAnchor.constraint(equalToConstant: 48),
            organizatorImage.widthAnchor.constraint(equalToConstant: 48),
            
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 244),
          
        ])
    }
}
