//
//  ExploreDetailHeader.swift
//  MyEventHub
//
//  Created by Дмирий Зядик on 22.11.2024.
//

import UIKit

class EventDetailHeader: UIView {
    
    // MARK: - UI
    
    private lazy var imageHeader : UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "party")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var bookmarkView : UIView = {
        let element = UIView()
        element.addSubview(bookmark)
        element.backgroundColor = .white.withAlphaComponent(0.3)
        element.layer.cornerRadius = 10
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var bookmark : UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "bookmark")
        element.tintColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var shareView : UIView = {
        let element = UIView()
        element.addSubview(shareImage)
        element.backgroundColor = .white.withAlphaComponent(0.3)
        element.layer.cornerRadius = 10
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var shareImage : UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "share")
        element.tintColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setConstrains()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView(){
        
        addSubview(imageHeader)
        addSubview(bookmarkView)
        addSubview(shareView)
    }
    
    private func setConstrains(){
        NSLayoutConstraint.activate([
            imageHeader.topAnchor.constraint(equalTo: topAnchor),
            imageHeader.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageHeader.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageHeader.heightAnchor.constraint(equalToConstant: 244),
            
            shareView.topAnchor.constraint(equalTo: topAnchor, constant: 195),
            shareView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14.32),
            shareView.heightAnchor.constraint(equalToConstant: 36),
            shareView.widthAnchor.constraint(equalToConstant: 36),
            
            shareImage.heightAnchor.constraint(equalToConstant: 24),
            shareImage.widthAnchor.constraint(equalToConstant: 24),
            shareImage.centerXAnchor.constraint(equalTo: shareView.centerXAnchor),
            shareImage.centerYAnchor.constraint(equalTo: shareView.centerYAnchor),
            
            
            bookmarkView.topAnchor.constraint(equalTo: topAnchor, constant: 44),
            bookmarkView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            bookmarkView.heightAnchor.constraint(equalToConstant: 36),
            bookmarkView.widthAnchor.constraint(equalToConstant: 36),
            
            bookmark.heightAnchor.constraint(equalToConstant: 15),
            bookmark.widthAnchor.constraint(equalToConstant: 14.9),
            bookmark.centerXAnchor.constraint(equalTo: bookmarkView.centerXAnchor),
            bookmark.centerYAnchor.constraint(equalTo: bookmarkView.centerYAnchor),
          
        ])
    }
}
    
