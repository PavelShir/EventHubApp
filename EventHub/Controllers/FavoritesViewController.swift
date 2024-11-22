//
//  FavoritesViewController.swift
//  EventHub
//
//  Created by Павел Широкий on 18.11.2024.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        self.hidesBottomBarWhenPushed = false

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}
