//
//  ExploreScreen.swift
//  MyEventHub
//
//  Created by Дмирий Зядик on 18.11.2024.
//

import UIKit

class HeaderExploreView: UIView {
    
    weak var delegate: ExploreViewController?
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
    
    private lazy  var currentLocationLabel : UILabel = {
        let element = UILabel()
        element.isUserInteractionEnabled = true
        element.text = "Current Location"
        element.textColor = .white.withAlphaComponent(0.7)
        element.font = .systemFont(ofSize: 12)
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(showCityPicker))
        element.addGestureRecognizer(gesture)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var downIcon : UIImageView = {
        let element = UIImageView()
        element.isUserInteractionEnabled = true
        element.image = UIImage(named: "down")
        element.tintColor = .white
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(showCityPicker))
        element.addGestureRecognizer(gesture)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    var cityLabel : UILabel = {
        let element = UILabel()
        element.isUserInteractionEnabled = true
        element.text = "Moscow"
        
        element.textColor = .white
        element.font = .systemFont(ofSize: 13)
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(showCityPicker))
        element.addGestureRecognizer(gesture)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        
        let placeholderText = NSAttributedString(string: "Search...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
      
        search.searchTextField.attributedPlaceholder = placeholderText
        search.searchTextField.textColor = .white
        
        search.translatesAutoresizingMaskIntoConstraints = false
        search.backgroundColor = UIColor(named: "darkBlue")
        
        search.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        search.searchTextField.backgroundColor = UIColor(named: "darkBlue")
        search.clipsToBounds = true
        
        let customImageView = UIImageView(image: UIImage(named: "searchExplore"))
        customImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 10)
        customImageView.contentMode = .scaleAspectFit
        
        search.searchTextField.leftView = customImageView
        search.searchTextField.leftViewMode = .always
        
        search.translatesAutoresizingMaskIntoConstraints = false
        
        return search
    }()
    
    private lazy var notificationButton : UIButton = {
        let element = UIButton(type: .custom)
        element.backgroundColor = UIColor(named: "primaryBlue")
        element.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        element.layer.cornerRadius = 0.5 * element.bounds.size.width
        element.clipsToBounds = true
        let image = UIImage(named: "bell")
        element.setImage(image, for: .normal)
        element.addTarget(self, action: #selector(notificationButtonPressed), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
     lazy var filterButton : UIButton = {
        let element = UIButton(type: .custom)
        element.backgroundColor = UIColor(named: "primaryBlue")
        let imageFilter = UIImage(systemName: "line.horizontal.3.decrease.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        element.setTitle("Filters", for: .normal)
        element.titleLabel?.font = .systemFont(ofSize: 12)

        element.layer.cornerRadius = 15
        element.setImage(imageFilter, for: .normal)

        element.addTarget(self, action: #selector(filterPressed), for: .touchUpInside)
        element.isUserInteractionEnabled = true

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
        addSubview(currentLocationLabel)
        addSubview(downIcon)
        addSubview(cityLabel)
        addSubview(searchBar)
        addSubview(notificationButton)
        addSubview(filterButton)
//        addSubview(headerView)
     //   headerView.addSubview(headerStack)
        //view.addSubview(customView)
        
        setupConstrains()
    }
    
    // MARK: - Actions
    
    @objc private func filterPressed() {
        print("filterPressed header")
        delegate?.filterPressed()
    }
    
    @objc func showCityPicker() {
        print("location press")
        delegate?.showCityPicker()
        // Do what you want
    }
    
    @objc func notificationButtonPressed(){
    }

}

extension HeaderExploreView {
    
    private func setupConstrains(){
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            currentLocationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            currentLocationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            downIcon.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            downIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 117),
            
            cityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            notificationButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            notificationButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            notificationButton.heightAnchor.constraint(equalToConstant: 36),
            notificationButton.widthAnchor.constraint(equalToConstant: 36),
            
            searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            searchBar.heightAnchor.constraint(equalToConstant: 30),
            
            filterButton.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            filterButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            filterButton.heightAnchor.constraint(equalToConstant: 30),
            filterButton.widthAnchor.constraint(equalToConstant: 75),
            
        ])
    }
}
