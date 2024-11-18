//
//  EventsViewController.swift
//  EventHub
//
//  Created by Anna Melekhina on 18.11.2024.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    private var segmentedControl = UISegmentedControl()
    private var tableView = UITableView()
    private var exploreButton = UIButton()
    
    private var events: [EventModel] = [
        EventModel(date: "Wed, Apr 28 • 5:30 PM", title: "Jo Malone London's Mother's Day Presents", location: "Radius Gallery • Santa Cruz, CA", imageName: "event1"),
        EventModel(date: "Fri, Apr 23 • 6:00 PM", title: "International Kids Safe Parents Night Out", location: "Lot 13 • Oakland, CA", imageName: "event2")
    ]
    
  // MARK: Lifecycle ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EventCell.self, forCellReuseIdentifier: "EventCell")
        
//        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
//        exploreButton.addTarget(self, action: #selector(exploreButtonTapped), for: .touchUpInside)
    }
    
    func setupUI() {
        
        
        segmentedControl = UISegmentedControl(items: ["UPCOMING", "PAST EVENTS"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = UIColor(white: 0.95, alpha: 1)
        segmentedControl.selectedSegmentTintColor = .white
            
            let normalTextAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.gray,
                .font: UIFont.systemFont(ofSize: 14)
            ]
            let selectedTextAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.blue,
                .font: UIFont.systemFont(ofSize: 14, weight: .bold)
            ]
            
        segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        segmentedControl.layer.cornerRadius = 40
        segmentedControl.layer.masksToBounds = true
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)

        
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
           
        exploreButton.setTitle("EXPLORE EVENTS", for: .normal)
        exploreButton.setTitleColor(.white, for: .normal)
        exploreButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        exploreButton.backgroundColor = UIColor.systemBlue
        exploreButton.layer.cornerRadius = 25
//            button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
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
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            
            exploreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            exploreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exploreButton.widthAnchor.constraint(equalToConstant: 250),
            exploreButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // Actions
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        print("Selected segment: \(sender.selectedSegmentIndex)")
        tableView.reloadData()
    }
    
    @objc func exploreButtonTapped() {
        print("Explore button tapped")
    }
    
    // MARK: TableView DataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        let event = events[indexPath.row]
        cell.configure(with: event)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacerView = UIView()
        spacerView.backgroundColor = .clear
        return spacerView
    }
}



#Preview { EventsViewController() }
