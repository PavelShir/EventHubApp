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
            generateVC(viewController: UINavigationController(rootViewController: BrowseViewController()), image: UIImage.home),
        
            generateVC(viewController: UINavigationController(rootViewController: CategoriesViewController()), image: UIImage.apps),
            
            generateVC(viewController: UINavigationController(rootViewController: BookmarksViewController()), image: UIImage.bookmark),
            
            generateVC(viewController: UINavigationController(rootViewController: ProfileViewController()), image: UIImage.profile)
        ]
    }

    private func generateVC(viewController: UIViewController, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.image = image
        return viewController
    }
}
