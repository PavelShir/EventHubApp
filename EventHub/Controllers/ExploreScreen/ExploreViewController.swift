//
//  ExploreScreen.swift
//  MyEventHub
//
//  Created by Дмирий Зядик on 18.11.2024.
//

import Foundation
import UIKit
import SwiftUI

class ExploreViewController: UIViewController {
    
    // MARK: - UI
   
    lazy var categoryCollectionView: CategoryCollectionView = {
        let element =  CategoryCollectionView(frame: CGRect(x: 0, y: 190, width: 402, height: 39))
        return element
    }()
    
    private lazy var eventViewController :EventCollectionView = {
        let element = EventCollectionView(frame: CGRect(x: 20, y: 290, width: 402, height: 255))
        
        return element
    }()
    
    private lazy var eventViewController2 :EventCollectionView = {
        let element = EventCollectionView(frame: CGRect(x: 20, y: 595, width: 402, height: 255))
        
        return element
    }()
    
    lazy var headerCustomView: HeaderExploreView = {
        let element =  HeaderExploreView(frame: CGRect(x: 0, y: 0, width: 402, height: 210))
        return element
    }()
    
    private lazy var upcomingStack : UIStackView = {
        let element = UIStackView(frame: CGRect(x: 20, y: 250, width: 362, height: 30))
        
        element.axis = .horizontal
        element.distribution = .equalSpacing
        
        let text1 = UILabel()
        text1.text = "Upcoming Events"
        text1.font = .systemFont(ofSize: 18)
        
        let text2 = UILabel()
        text2.text = "SeeAll"
        text2.font = .systemFont(ofSize: 14)
        text2.textColor = .gray
        
        element.addArrangedSubview(text1)
        element.addArrangedSubview(text2)
        
        return element
    }()
    
    private lazy var nearbyStack : UIStackView = {
        let element = UIStackView(frame: CGRect(x: 20, y: 560, width: 362, height: 30))
        
        element.axis = .horizontal
        element.distribution = .equalSpacing
        
        let text1 = UILabel()
        text1.text = "Nearby You"
        text1.font = .systemFont(ofSize: 18)
        
        let text2 = UILabel()
        text2.text = "SeeAll"
        text2.font = .systemFont(ofSize: 14)
        text2.textColor = .gray
        
        element.addArrangedSubview(text1)
        element.addArrangedSubview(text2)
        
        return element
    }()
   
    
    
    // MARK: - Life Cicle
    
    override func viewDidLoad() {
            super.viewDidLoad()
            setView()
            setupConstrains()
            
        }
    
    private func setView(){
        view.backgroundColor =  .white
        // view.addSubview(headerView)
        //headerView.addSubview(headerStack)
        view.addSubview(headerCustomView)
        view.addSubview(categoryCollectionView)
        view.addSubview(upcomingStack)
        view.addSubview(eventViewController)
       // view.addSubview(eventCardView)
        view.addSubview(nearbyStack)
        view.addSubview(eventViewController2)
    }
    
    // MARK: - Actions
    
    @objc func notificationButtonPressed(){
        
    }

}

extension ExploreViewController {
    
    private func setupConstrains(){
        NSLayoutConstraint.activate([
            
          
        ])
    }
}



//struct ViewControllerProvider: PreviewProvider {
//    static var previews: some View {
//        ExploreViewController().showPreview()
//    }
//}
    
