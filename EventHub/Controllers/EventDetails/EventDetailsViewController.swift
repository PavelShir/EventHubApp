//
//  ExploreDetailsVC.swift
//  MyEventHub
//
//  Created by Дмирий Зядик on 22.11.2024.
//

import Foundation
import UIKit
import SwiftUI
import Kingfisher

class EventDetailsViewController: UIViewController {
    
    var eventDetail: Event?
    
    private lazy var headerView : EventDetailHeader = {
        let element = EventDetailHeader()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let bodyLabel: UILabel = {
            let view = UILabel()
        view.numberOfLines = 2
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
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
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.6
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    private let descriptionLocationLabel: UILabel = {
            let view = UILabel()
            view.text = ""
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
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
            view.text = "" /*14 Decenber, 2021"*/
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    private let descriptionOrganizatorLabel: UILabel = {
            let view = UILabel()
            view.text = "" /*Tuesday, 4:00PM - 9:00PM"*/
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
//        organizatorImage.image = UIImage(named: "organizator")
//        captionOrganizatorLabel.text = "Ashfak Sayem"
//        descriptionOrganizatorLabel.text = "Organizer"
    }
    
    private lazy var aboutLabel : UILabel = {
        let element = UILabel()
        element.text = "About Event"
        element.font = .systemFont(ofSize: 18)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
   // let exploreDetailRow = ExploreDetailRow()
    var bookmark : UIButton = {
        let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: "bookmark"), for: .normal)
            button.tintColor = .white
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setupConstrains()
        
        getImageData()
        getData()
        getPlaceData()
        
        bookmark.addTarget(self, action: #selector(toggleBookmark), for: .touchUpInside)

    }
    
    func setView(){
        bodyLabel.font = .systemFont(ofSize: 25)
        
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
        view.addSubview(bookmark)
        view.bringSubviewToFront(bookmark)

        
    }
    
    func getImageData() {
        
        let image = headerView.imageHeader
//        image.image = UIImage(named: "girlimage")
        if let urlToImage = eventDetail?.images {
            image.setImage(url: urlToImage)
        } else {
            image.image = UIImage(named: "girlimage")
        }
    }
    
    func getData() {
        bodyLabel.text = eventDetail?.title
        contentTextView.text = eventDetail?.description

        captionLabel.text = convertDate(date: eventDetail?.startDate)
        descriptionLabel.text = convertTime(date: eventDetail?.startDate)
    }
    func getPlaceData() {

        captionLocationLabel.text = ""
        descriptionLocationLabel.text = ""

        guard let placeId = eventDetail?.placeId else {
            captionLocationLabel.text = eventDetail?.locationSlug
            descriptionLocationLabel.text = ""
                return
            }
        
        loadPlace(placeId: placeId) { [weak self] place in
                DispatchQueue.main.async {
                    if let place = place {
                        self?.captionLocationLabel.text = place.title ?? "No address available"
                        self?.descriptionLocationLabel.text = place.address ?? "No address available"
                    } else {
                        self?.captionLocationLabel.text = self?.eventDetail?.locationSlug
                        self?.descriptionLocationLabel.text = ""
                    }
                }
            }
    }
    
    @objc private func toggleBookmark() {
        
        
        if bookmark.image(for: .normal) == UIImage(systemName: "bookmark") {
            bookmark.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
               
               var favorites = StorageManager.shared.loadFavorite()
               
            if favorites.contains(where: { $0.id == eventDetail?.id }) {
                showAlreadyInFavoritesAlert(for: eventDetail!)
               } else {
                   favorites.append(eventDetail!)
                   StorageManager.shared.saveFavorites(favorites)
                   showFavoriteAddedAlert(for: eventDetail!)
                   
                   NotificationCenter.default.post(name: .favoriteEventAdded, object: eventDetail!)
               }
           } else {
               // Если иконка уже заполненная, это значит событие в избранном, убираем его
               bookmark.setImage(UIImage(systemName: "bookmark"), for: .normal)
               
               var favorites = StorageManager.shared.loadFavorite()
               
               if let index = favorites.firstIndex(where: { $0.id == eventDetail?.id }) {
                   favorites.remove(at: index)
                   StorageManager.shared.saveFavorites(favorites)
                    
               }
           }
       }
    
    private func showFavoriteAddedAlert(for event: Event) {
        let alertController = UIAlertController(
            title: "Added to Favorites",
            message: "\(event.title)",
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    private func showAlreadyInFavoritesAlert(for event: Event) {
        let alertController = UIAlertController(
            title: "Removed from Favorites!",
            message: "\(event.title)",
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    private func convertDate(date: Int?) -> String {
        
        guard let date = date else {
                return "No date information"
            }
            
            let timeInterval = TimeInterval(date)
            
            let dateObject = Date(timeIntervalSince1970: timeInterval)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMMM, yyyy"
            return dateFormatter.string(from: dateObject)
    }
    
    private func convertTime(date: Int?) -> String {
        
        guard let date = date else {
                return ""
            }
            
            let timeInterval = TimeInterval(date)
            
            let dateObject = Date(timeIntervalSince1970: timeInterval)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: dateObject)
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
            
            bookmark.heightAnchor.constraint(equalToConstant: 20),
            bookmark.widthAnchor.constraint(equalToConstant: 20),
            bookmark.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            bookmark.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
          
        ])
    }
}
