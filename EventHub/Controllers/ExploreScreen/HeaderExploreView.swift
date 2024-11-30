//
//  ExploreScreen.swift
//  MyEventHub
//
//  Created by Дмирий Зядик on 18.11.2024.
//

import Foundation
import UIKit
import SwiftUI

class HeaderExploreView: UIView {
    
    // MARK: - UI
    
    private lazy var headerView : UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(named: "darkBlue")
        element.clipsToBounds = true
        element.layer.cornerRadius = 30
        element.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var currentLocationRow : UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        
        let label = UILabel()
        label.text = "Current Location"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        
        let gap = UIView()
        gap.widthAnchor.constraint(equalToConstant: 5).isActive = true
        
        element.addArrangedSubview(label)
        element.addArrangedSubview(gap)
        element.addArrangedSubview(iconTriangle)
        element.addArrangedSubview(UIView())
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var iconTriangle : UIImageView = {
        let element = UIImageView()
        
        element.image = UIImage(systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12.0))
        element.tintColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var locationLabel : UILabel = {
        let element = UILabel()
        element.text = "New York, USA"
        element.textColor = .white
        element.font = .systemFont(ofSize: 13)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var locationCol : UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.addArrangedSubview(currentLocationRow)
        element.addArrangedSubview(locationLabel)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var locationRow : UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .fillProportionally
        
        element.addArrangedSubview(locationCol)
        element.addArrangedSubview(notificationButton)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var notificationButton : UIButton = {
        let element = UIButton(type: .custom)
        element.backgroundColor = UIColor(named: "primaryBlue")
        element.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        element.layer.cornerRadius = 0.5 * element.bounds.size.width
        element.clipsToBounds = true
        let image = UIImage(systemName: "bell.badge")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        element.setImage(image, for: .normal)
        element.addTarget(self, action: #selector(notificationButtonPressed), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var searchRow : UIStackView = {
        let element = UIStackView()
        element.addArrangedSubview(searchIcon)
        element.addArrangedSubview(separate)
        element.addArrangedSubview(searclTextField)
        element.addArrangedSubview(UIView())
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var filterRow : UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.addArrangedSubview(searchRow)
        element.addArrangedSubview(filterButton)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var searchIcon : UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24.0))
        element.tintColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var separate : UILabel = {
        let element = UILabel()
        element.text = " | "
        element.font = .systemFont(ofSize: 24)
        element.textColor = UIColor.lightGray
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var searclTextField : UITextField = {
        let element = UITextField()
        element.font = .systemFont(ofSize: 20.33)
        let placeholderText = NSAttributedString(string: "Search...",
                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        element.attributedPlaceholder = placeholderText
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
     var filterButton : UIButton = {
        let element = UIButton(type: .custom)
        element.backgroundColor = UIColor(named: "primaryBlue")
        let image = UIImage(systemName: "line.3.horizontal.decrease")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        element.setTitle("Filters", for: .normal)
        element.titleLabel?.font = .systemFont(ofSize: 12)
        element.layer.cornerRadius = 10
        element.setImage(image, for: .normal)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var headerStack : UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.addArrangedSubview(locationRow)
        element.addArrangedSubview(filterRow)
        element.addArrangedSubview(UIView())
       
        element.setCustomSpacing(15.83, after: locationRow)
        element.setCustomSpacing(5, after: filterRow)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - Life Cicle
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setView()
        
        }
    required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
   
    private func setView(){
        
        addSubview(headerView)
        headerView.addSubview(headerStack)
        //view.addSubview(customView)
        
        setupConstrains()
    }
    
    // MARK: - Actions
    
    @objc func notificationButtonPressed(){
    }

}

extension HeaderExploreView {
    
    private func setupConstrains(){
        NSLayoutConstraint.activate([
           
            
            headerStack.topAnchor.constraint(equalTo: headerView.topAnchor),
            headerStack.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerStack.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            headerStack.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
          
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            locationRow.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 70),
            locationRow.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 30),
            locationRow.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -30),
                                   
            notificationButton.widthAnchor.constraint(equalToConstant: 36),
            notificationButton.heightAnchor.constraint(equalToConstant: 36),
            
            searchIcon.widthAnchor.constraint(equalToConstant: 30),
            searchIcon.heightAnchor.constraint(equalToConstant: 24),
            
            iconTriangle.widthAnchor.constraint(equalToConstant: 12),
            
            currentLocationRow.widthAnchor.constraint(equalToConstant: 10),
            
            filterButton.widthAnchor.constraint(equalToConstant: 75),
            filterButton.heightAnchor.constraint(equalToConstant: 32.14),
        ])
    }
}
