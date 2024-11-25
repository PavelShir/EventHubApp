//
//  EventsViewController.swift
//  EventHub
//
//  Created by Anna Melekhina on 18.11.2024.
//

import UIKit

class EventsViewController: UIViewController {
    
    private var segmentedControl = UISegmentedControl()
    private var tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var exploreButton = UIButton()
    private let date = Date()
    
    private let imageEmpty = UIImageView()
    private let labelEmpty = UILabel()
    private let smallLabelEmpty = UILabel()
    
    private var events: [Event] = []
    
    private var upcomingEvents: [Event] = []
    
    // MARK: Lifecycle ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        

        setupUI()
        loadItemsInSegment()
        setupUIEmpty()
        showEmptyScreen()
        
        
        self.title = "Events"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EventCell.self, forCellReuseIdentifier: "EventCell")
        
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        exploreButton.addTarget(self, action: #selector(exploreButtonTapped), for: .touchUpInside)
    }
    
    
    func setupUI() {
        
        setUpSegment()
        
        tableView.separatorColor = .white
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
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: exploreButton.topAnchor, constant: -5),
            
            exploreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            exploreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exploreButton.widthAnchor.constraint(equalToConstant: 250),
            exploreButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    private func configureImageEmpty() {
        imageEmpty.image = UIImage(named: "noEvent")
        view.addSubview(imageEmpty)
        imageEmpty.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func configureLabelEmpty() {
        
        labelEmpty.text = "No Upcoming Events"
        labelEmpty.font = UIFont.boldSystemFont(ofSize: 18)
        labelEmpty.textColor = .black
        labelEmpty.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelEmpty)
    }
    
    private func configureSmallLabelEmpty() {
        smallLabelEmpty.text = "Check out new events and add them to your calendar"
        smallLabelEmpty.font = UIFont(name: "AirbnbCerealApp", size: 14)
        smallLabelEmpty.textColor = .gray
        smallLabelEmpty.textAlignment = .center
        smallLabelEmpty.numberOfLines = 0
        view.addSubview(smallLabelEmpty)
        smallLabelEmpty.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupUIEmpty() {
        
        configureImageEmpty()
        configureLabelEmpty()
        configureSmallLabelEmpty()
        
        NSLayoutConstraint.activate([
            
            imageEmpty.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageEmpty.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageEmpty.widthAnchor.constraint(equalToConstant: 200),
            imageEmpty.heightAnchor.constraint(equalToConstant: 200),
            
            labelEmpty.topAnchor.constraint(equalTo: imageEmpty.bottomAnchor, constant: 16),
            labelEmpty.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            smallLabelEmpty.topAnchor.constraint(equalTo: labelEmpty.bottomAnchor, constant: 8),
            smallLabelEmpty.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            smallLabelEmpty.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func setUpSegment() {
        
        segmentedControl = CapsuleSegmentedControl(items: ["UPCOMING", "PAST EVENTS"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        view.addSubview(segmentedControl)
        segmentedControl.selectedSegmentIndex = 0
        
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
        
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        loadItemsInSegment()
        showEmptyScreen()
        
    }
    
    @objc private func exploreButtonTapped() {
        
        let allEventsVC = AllEventsViewController()
        allEventsVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(allEventsVC, animated: true)
    }
    
    private func loadItemsInSegment() {
        let index = segmentedControl.selectedSegmentIndex
        
        let currentDate = String(Date().timeIntervalSince1970)
        let filterUntrilToday = EventFilter(location: .moscow, actualUntil: currentDate)
        let filterAfterToday = EventFilter(location: .moscow, actualSince: currentDate)

        
        switch index {
            
        case 0: upcomingEvents = loadEvents(with: filterAfterToday)
            tableView.reloadData()
        case 1: events = loadEvents(with: filterAfterToday)
            tableView.reloadData()

        default: print("no index")
        }
        
        tableView.reloadData()
    }
    
    private func showEmptyScreen() {
        
        if upcomingEvents.isEmpty {
            imageEmpty.isHidden = false
            labelEmpty.isHidden = false
            smallLabelEmpty.isHidden = false
            
        } else {
            imageEmpty.isHidden = true
            labelEmpty.isHidden = true
            smallLabelEmpty.isHidden = true
        }
    }
}

// MARK: TableView DataSource & Delegate

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if upcomingEvents.count < 5 {
            return upcomingEvents.count
        } else {
            return 5
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        let event = upcomingEvents[indexPath.row]
        cell.configure(with: event)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // переход на Ивент + передать данные об ивенте
        
        //        let selectedEvent = eventData[indexPath.row]
        //        let eventVC = Explore()
        //        eventVC.event = selectedEvent
        //
        //            navigationController?.pushViewController(eventVC, animated: true)
        //            tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}



//#Preview { EventsViewController() }
