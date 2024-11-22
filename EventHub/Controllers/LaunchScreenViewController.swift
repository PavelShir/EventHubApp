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
        view.backgroundColor = .white
        
        addCircles()
        addBlur()
        
        let hStack = createStack()
        view.addSubview(hStack)
        
        NSLayoutConstraint.activate([
            hStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            hStack.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.switchToMainScreen()
        }
    }
    
    
    private func switchToMainScreen() {
        guard let window = UIApplication.shared.windows.first else { return }
        
        let mainViewController = TabBarViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        window.rootViewController = navigationController
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
    }
    
    private func addCircles() {
        view.addSubview(addCircle(x: 270, y: 70, diameter: 110))
        view.addSubview(addCircle(x: 270, y: 500, diameter: 300))
        view.addSubview(addCircle(x: 30, y: 500, diameter: 80))
    }
    
    
    
    private func addBlur() {
        let blurEffect = UIBlurEffect(style: .regular)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = view.bounds
        effectView.alpha = 1
        view.addSubview(effectView)
        
    }
    
    private func addCircle(x: CGFloat, y: CGFloat, diameter: CGFloat) -> UIView {
        
        let circle = UIView()
        circle.frame = CGRect(x: x, y: y, width: diameter, height: diameter)
        circle.backgroundColor = UIColor(named: "primaryBlue")?.withAlphaComponent(0.1)
        circle.layer.cornerRadius = diameter / 2
        return circle
    }
    
    private func createStack() -> UIStackView {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.spacing = 1
        hStack.alignment = .center
        hStack.distribution = .equalCentering
        
        let imageView = UIImageView()
        imageView.image =  UIImage(named: "eIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label1 = UILabel()
        label1.text = "vent"
        label1.textColor = UIColor(named: "primaryBlue")
        label1.font = UIFont.systemFont(ofSize: 45, weight: .medium)
        label1.translatesAutoresizingMaskIntoConstraints = false
        
        
        let label2 = UILabel()
        label2.text = "Hub"
        label2.textColor = UIColor(red: 0, green: 0.97, blue: 1, alpha: 1)
        label2.font = UIFont.systemFont(ofSize: 45, weight: .medium)
        label2.translatesAutoresizingMaskIntoConstraints = false
        
        hStack.addArrangedSubview(imageView)
        hStack.addArrangedSubview(label1)
        hStack.addArrangedSubview(label2)
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        return hStack
    }
    
}

//#Preview { LaunchScreenViewController() }
