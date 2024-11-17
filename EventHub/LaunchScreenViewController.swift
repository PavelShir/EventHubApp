//
//  LaunchScreenViewController.swift
//  EventHub
//
//  Created by Павел Широкий on 17.11.2024.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.switchToMainScreen()
                }
    }
    
    private func switchToMainScreen() {
        guard let window = UIApplication.shared.windows.first else { return }
        
        let mainViewController = ViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        window.rootViewController = navigationController
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
    }
}
