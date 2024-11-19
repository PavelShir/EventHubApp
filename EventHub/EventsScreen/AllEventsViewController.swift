//
//  AllEventsViewController.swift
//  EventHub
//
//  Created by Anna Melekhina on 19.11.2024.
//

import UIKit

class AllEventsViewController: UIViewController {

    private var tableView = UITableView()

    private var events: [EventModel] = [
        EventModel(date: "Wed, Apr 28 5:30 PM", title: "Jo Malone London's Mother's", place: "Santa Cruz, CA", imageName: "girlimage"),
        EventModel(date: "Fri, Apr 23 6:00 PM", title: "International Kids Safe Parents Night Out", place: "Oakland, CA", imageName: "girlimage"),
        EventModel(date: "Wed, Apr 28 5:30 PM", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
        EventModel(date: "Wed, Apr 28 5:30 PM", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
        EventModel(date: "Wed, Apr 28 5:30 PM", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
        EventModel(date: "Wed, Apr 28 5:30 PM", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
        EventModel(date: "Wed, Apr 28 5:30 PM", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
        EventModel(date: "Wed, Apr 28 5:30 PM", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EventCell.self, forCellReuseIdentifier: "EventCell")
        
     }
    

    private func setupUI() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        
        NSLayoutConstraint.activate([
             
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.2),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

// MARK: TableView DataSource & Delegate

extension AllEventsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        let event = events[indexPath.row]
        cell.configure(with: event)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

#Preview { AllEventsViewController() }
