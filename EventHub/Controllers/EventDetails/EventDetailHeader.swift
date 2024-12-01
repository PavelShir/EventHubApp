//
//  ExploreDetailHeader.swift
//  MyEventHub
//
//  Created by Дмирий Зядик on 22.11.2024.
//

import UIKit

class EventDetailHeader: UIView {
    
    // MARK: - UI
    
    var imageHeader : UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "")
        element.contentMode = .scaleAspectFill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var bookmarkView : UIView = {
        let element = UIView()
//        element.addSubview(bookmark)
        element.backgroundColor = .white.withAlphaComponent(0.3)
        element.layer.cornerRadius = 10
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
  
    
    private lazy var shareView : UIView = {
        let element = UIView()
        element.addSubview(shareButton)
        element.backgroundColor = .white.withAlphaComponent(0.3)
        element.layer.cornerRadius = 10
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
      var shareButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(named: "share")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
            
            shareButton.heightAnchor.constraint(equalToConstant: 24),
            shareButton.widthAnchor.constraint(equalToConstant: 24),
            shareButton.centerXAnchor.constraint(equalTo: shareView.centerXAnchor),
            shareButton.centerYAnchor.constraint(equalTo: shareView.centerYAnchor),
            
            
            bookmarkView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            bookmarkView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            bookmarkView.heightAnchor.constraint(equalToConstant: 36),
            bookmarkView.widthAnchor.constraint(equalToConstant: 36),
            
            
          
        ])
    }
}
    
