//
//  EventsViewController.swift
//  EventHub
//
//  Created by Anna Melekhina on 18.11.2024.
//

import UIKit

class EventsViewController: UIViewController {
    
    private var segmentedControl = UISegmentedControl()
    private var tableView = UITableView()
    private var exploreButton = UIButton()
    private let date = Date()

    
    private var events: [EventModel] = [
        EventModel(date: "1698764400", title: "Jo Malone London's Mother's", place: "Santa Cruz, CA", imageName: "girlimage"),
        EventModel(date: "1732027600", title: "International Kids Safe Parents Night Out", place: "Oakland, CA", imageName: "girlimage"),
        EventModel(date: "1698850800", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
        EventModel(date: "1732017600", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
        EventModel(date: "1698850800", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
        EventModel(date: "1732017600", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
        EventModel(date: "1698850800", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
        EventModel(date: "1698764400", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
    ]
    
    private var filteredEvents: [EventModel] = []
    
    // MARK: Lifecycle ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EventCell.self, forCellReuseIdentifier: "EventCell")
        
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        exploreButton.addTarget(self, action: #selector(exploreButtonTapped), for: .touchUpInside)
    }
    
    func setupUI() {
        
        
        segmentedControl = UISegmentedControl(items: ["UPCOMING", "PAST EVENTS"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = UIColor(white: 1, alpha: 0.3)
        segmentedControl.selectedSegmentTintColor = .white
        
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont(name: "AirbnbCerealApp", size: 15) ?? .systemFont(ofSize: 15)
        ]
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "primaryBlue") ?? .blue,
            .font: UIFont(name: "AirbnbCerealApp", size: 15) ?? .systemFont(ofSize: 15)
        ]
        
        segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        
        segmentedControl.layer.cornerRadius = 40
        segmentedControl.layer.borderWidth = 0
        segmentedControl.layer.masksToBounds = true
        segmentedControl.layer.borderColor = UIColor.white.cgColor

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
//        tableView.separatorColor = .white
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        
        
        exploreButton.setTitle("EXPLORE EVENTS", for: .normal)
        exploreButton.titleLabel?.font = UIFont(name: "AirbnbCerealApp", size: 15)
        exploreButton.backgroundColor = UIColor(named: "primaryBlue")
        exploreButton.layer.cornerRadius = 25
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "arrow.right.circle")
        config.imagePlacement = .trailing
        config.imagePadding = 8
        exploreButton.tintColor = .white
        
        exploreButton.configuration = config
        view.addSubview(exploreButton)
        exploreButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalToConstant: 300),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: exploreButton.topAnchor, constant: -5),
            
            exploreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            exploreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exploreButton.widthAnchor.constraint(equalToConstant: 250),
            exploreButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        print("Selected segment: \(sender.selectedSegmentIndex)")
        
        let currentDate = Date().timeIntervalSince1970
        let index = sender.selectedSegmentIndex
        
        switch index {
            
        case 0: filteredEvents = events.filter { Double($0.date)! >= currentDate &&  Double($0.date)! < currentDate + 604800}
        case 1: filteredEvents = events.filter { Double($0.date)! < currentDate }
        default: print("no index")
        }
        
        tableView.reloadData()
    }
    
    @objc func exploreButtonTapped() {
        print("Explore button tapped")
        
        let allEventsVC = AllEventsViewController()
        allEventsVC.modalPresentationStyle = .fullScreen
        present(allEventsVC, animated: true)
    }
}

// MARK: TableView DataSource & Delegate

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredEvents.count < 5 {
            return filteredEvents.count
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        let event = filteredEvents[indexPath.row]
        cell.configure(with: event)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
  
    //разделитель
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//           let separatorView = UIView()
//           separatorView.backgroundColor = .red
//    
//           separatorView.frame = CGRect(x: 6, y: cell.frame.size.height - 1, width: cell.frame.size.width, height: 24)
//           cell.addSubview(separatorView)
//       }
    
}



#Preview { EventsViewController() }
