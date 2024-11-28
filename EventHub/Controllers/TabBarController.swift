//
//  TabBarController.swift
//  EventHub
//
//  Created by Павел Широкий on 18.11.2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private lazy var centerButton: UIButton = {
        let centerButton = UIButton()
        centerButton.backgroundColor = UIColor(red: 0.34, green: 0.41, blue: 1, alpha: 1)
        centerButton.layer.cornerRadius = 27
        let configuration = UIImage.SymbolConfiguration(pointSize: 23, weight: .light)
        let largeIcon = UIImage(systemName: "bookmark", withConfiguration: configuration)
        centerButton.setImage(largeIcon, for: .normal)
        centerButton.tintColor = .white
        centerButton.layer.shadowColor = UIColor.black.cgColor
        centerButton.layer.shadowOpacity = 0.2
        centerButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        centerButton.layer.shadowRadius = 10
        
        centerButton.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
        return centerButton
        
    }()
    
    //    private let customTabBar = CustomTabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setupCenterButton()
        addTabBarShadow()
//        loadEvents()
        
        let filter = EventFilter(location: .moscow, actualSince: String(1722076800) )  //3 мес назад
        let eventVC = EventsViewController()
        eventVC.eventsDisplayed = loadEvents(with: filter)

 
        
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: UINavigationController(rootViewController: ExploreViewController()), image: UIImage(named: "explore.fill"), title: String(localized: "Explore")),
            
            generateVC(viewController: UINavigationController(rootViewController: EventsViewController()), image: UIImage(named: "events"), title: String(localized: "Events")),
            
            generateVC(viewController: UINavigationController(rootViewController: FavoritesViewController()), image: UIImage(named: " "), title: String(localized: " ")),
            
            generateVC(viewController: UINavigationController(rootViewController: MapViewController()), image: UIImage(named: "map"), title: String(localized: "Map")),
            

            generateVC(viewController: UINavigationController(rootViewController: MyProfileViewController()), image: UIImage(named: "Profile"), title: String(localized: "Profile"))

        ]
    }
    
    private func generateVC(viewController: UIViewController, image: UIImage?, title: String?) -> UIViewController {
        viewController.tabBarItem.image = image
        viewController.tabBarItem.title = title
        return viewController
    }
    
    
    private func setupCenterButton() {
        
        
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        tabBar.addSubview(centerButton)
        
        NSLayoutConstraint.activate([
            centerButton.heightAnchor.constraint(equalToConstant: 54),
            centerButton.widthAnchor.constraint(equalToConstant: 54),
            centerButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            centerButton.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -30)
        ])
        
    }
    
    @objc private func centerButtonTapped() {
        selectedIndex = 2
        centerButton.backgroundColor = UIColor(red: 0.92, green: 0.34, blue: 0.34, alpha: 1)
        
    }
    
    private func addTabBarShadow() {
        
        tabBar.layer.shadowColor = UIColor.gray.cgColor
        tabBar.layer.shadowRadius = 20
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowOpacity = 0.10
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .white
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
        
        
    }
    
}

extension TabBarViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let selectedIndex = self.tabBar.items?.firstIndex(of: item)
        if selectedIndex != 2 {
            centerButton.backgroundColor = UIColor(red: 0.34, green: 0.41, blue: 1, alpha: 1)
        } else {
            centerButton.backgroundColor = UIColor(red: 0.92, green: 0.34, blue: 0.34, alpha: 1)
        }
    }
}
//#Preview { TabBarViewController()}
