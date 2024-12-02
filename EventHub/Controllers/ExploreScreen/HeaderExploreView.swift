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
//        addSubview(currentLocationLabel)
        
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
            
//            currentLocationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 68),
//            currentLocationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            
//            headerStack.topAnchor.constraint(equalTo: headerView.topAnchor),
//            headerStack.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
//            headerStack.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
//            headerStack.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
//          

//            
//            headerView.heightAnchor.constraint(equalToConstant: 179),
//            
//            locationRow.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 60),
//            locationRow.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
//            locationRow.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -30),
//            
            //currentLocationRow.heightAnchor.constraint(equalToConstant: 10),
            
//            notificationButton.widthAnchor.constraint(equalToConstant: 36),
//            notificationButton.heightAnchor.constraint(equalToConstant: 36),
            
            //searchIcon.widthAnchor.constraint(equalToConstant: 30),
            //searchIcon.heightAnchor.constraint(equalToConstant: 24),
            
           // iconTriangle.widthAnchor.constraint(equalToConstant: 10),
            //iconTriangle.heightAnchor.constraint(equalToConstant: 5),
            
//            currentLocationRow.widthAnchor.constraint(equalToConstant: 10),
            
//            filterButton.widthAnchor.constraint(equalToConstant: 75), //75
//            filterButton.heightAnchor.constraint(equalToConstant: 32.14),
        ])
    }
}
