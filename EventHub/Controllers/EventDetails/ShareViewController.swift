//
//  SharreViewController.swift
//  EventHub
//
//  Created by Anna Melekhina on 30.11.2024.
//

import UIKit

class ShareViewController: UIViewController {
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    let slideIdicator: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.roundCorners(.allCorners, radius: 5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let copyButton = UIButton()
    let whatsappButton = UIButton()
    let facebookButton = UIButton()
    let messengerButton = UIButton()
    let twitterButton = UIButton()
    let instagramButton = UIButton()
    let skypeButton = UIButton()
    let messageButton = UIButton()
    
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CANCEL", for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "AirbnbCerealApp", size: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let topStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let bottomStack: UIStackView = {
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        setupUI()
        
        
        copyButton.addTarget(self, action: #selector(shareButtonPressed ), for: .touchUpInside)
        whatsappButton.addTarget(self, action: #selector(shareButtonPressed ), for: .touchUpInside)
        facebookButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        messengerButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        twitterButton.addTarget(self, action: #selector(shareButtonPressed ), for: .touchUpInside)
        instagramButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        skypeButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        messageButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    private func configureButton(button: UIButton, image: String) {
        var buttonConfig = UIButton.Configuration.plain()
        buttonConfig.image = UIImage(named: image)
        buttonConfig.imagePadding = 8
        buttonConfig.imagePlacement = .top
        
        button.configuration = buttonConfig
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.setTitle("", for: .normal)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 80),
            button.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func createStack(button: UIButton, title: String) -> UIStackView {
        let buttonStack = UIStackView()
        buttonStack.axis = .vertical
        buttonStack.alignment = .center
        buttonStack.spacing = 4
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        let button = button
        
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: "AirbnbCerealApp", size: 13)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        buttonStack.addArrangedSubview(button)
        buttonStack.addArrangedSubview(label)
        buttonStack.translatesAutoresizingMaskIntoConstraints = true
        
        return buttonStack
    }
    
    @objc private func shareButtonPressed() {
        let alert = UIAlertController(
            title: "Shared",
            message: "You shared this Event on Social media!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func cancelPressed() {
        self.dismiss(animated: true)
    }
    func setupUI() {
        
        view.backgroundColor = .white
        
        configureButton(button: copyButton, image: "copy_link")
        configureButton(button: whatsappButton, image: "whatsapp")
        configureButton(button: facebookButton, image: "facebook")
        configureButton(button: messengerButton, image: "messenger")
        configureButton(button: twitterButton, image: "twitter")
        configureButton(button: instagramButton, image: "instagram")
        configureButton(button: skypeButton, image: "skype")
        configureButton(button: messageButton, image: "message")
        
        
        let copyStack = createStack(button: copyButton, title: "Copy link")
        let whatsappStack = createStack(button: whatsappButton, title: "WhatsApp")
        let facebookStack = createStack(button: facebookButton, title: "Facebook")
        let messengerStack = createStack(button: messengerButton, title: "Messenger")
        let twitterStack = createStack(button: twitterButton, title: "Twitter")
        let instagramStack = createStack(button: instagramButton, title: "Instagram")
        let skypeStack = createStack(button: skypeButton, title: "Skype")
        let messageStack = createStack(button: messageButton, title: "Message")
        
        topStack.addArrangedSubview(copyStack)
        topStack.addArrangedSubview(whatsappStack)
        topStack.addArrangedSubview(facebookStack)
        topStack.addArrangedSubview(messengerStack)
        
        bottomStack.addArrangedSubview(twitterStack)
        bottomStack.addArrangedSubview(instagramStack)
        bottomStack.addArrangedSubview(skypeStack)
        bottomStack.addArrangedSubview(messageStack)
        
        
        let mainStack = UIStackView(arrangedSubviews: [topStack, bottomStack])
        mainStack.axis = .vertical
        mainStack.spacing = 0
        mainStack.distribution = .fillEqually
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainStack)
        view.addSubview(cancelButton)
        view.addSubview(slideIdicator)
        
        NSLayoutConstraint.activate([
            
            slideIdicator.heightAnchor.constraint(equalToConstant: 40),
            slideIdicator.widthAnchor.constraint(equalToConstant: 100),
            slideIdicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slideIdicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),

            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainStack.heightAnchor.constraint(equalToConstant: 260),
            mainStack.widthAnchor.constraint(equalToConstant: 200),
            mainStack.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -30),
            
            
            cancelButton.heightAnchor.constraint(equalToConstant: 70),
            cancelButton.widthAnchor.constraint(equalToConstant: 300),
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
            
        ])
    }
    
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let draggedToDismiss = (translation.y > view.frame.size.height/3.0)
            let dragVelocity = sender.velocity(in: view)
            if (dragVelocity.y >= 1300) || draggedToDismiss {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    
    
}

//#Preview { ShareViewController() }
