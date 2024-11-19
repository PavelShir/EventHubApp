//
//  TabBarController.swift
//  EventHub
//
//  Created by Павел Широкий on 18.11.2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        
    }

    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: UINavigationController(rootViewController: ExploreViewController()), image: UIImage(named: "explore.fill"), title: String(localized: "Explore")),
        
            generateVC(viewController: UINavigationController(rootViewController: EventsViewController()), image: UIImage(named: "events"), title: String(localized: "Events")),
            
            generateVC(viewController: UINavigationController(rootViewController: FavoritesViewController()), image: UIImage(named: "favorites"), title: String(localized: "")),
            
            generateVC(viewController: UINavigationController(rootViewController: MapViewController()), image: UIImage(named: "map"), title: String(localized: "Map")),
            
            generateVC(viewController: UINavigationController(rootViewController: MyProfileViewController()), image: UIImage(named: "profile"), title: String(localized: "Profile"))
        ]
    }

    private func generateVC(viewController: UIViewController, image: UIImage?, title: String?) -> UIViewController {
        viewController.tabBarItem.image = image
        viewController.tabBarItem.title = title
        return viewController
    }
}
