//
//  AllEventsViewController.swift
//  EventHub
//
//  Created by Anna Melekhina on 19.11.2024.
//

import UIKit

class AllEventsViewController: UIViewController {
    
    private var tableView = UITableView()
    private let currentDate = Int(Date().timeIntervalSince1970)
    var favoritesViewController: FavoritesViewController?

    
    var events: [Event] = []
    
    private var filteredEvents: [Event] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        filteredEvents = filterEvents()
        tableView.reloadData()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EventCell.self, forCellReuseIdentifier: "EventCell")
        
    }
    
    
    private func setupUI() {
        
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearchButton))
        
        
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func didTapSearchButton() {
        let searchVC = SearchViewController()
        searchVC.hidesBottomBarWhenPushed = true
        searchVC.events = filteredEvents
        navigationController?.pushViewController(searchVC, animated: true)
        
    }
    
    private func filterEvents() -> [Event] {
        
        filteredEvents = events.sorted {
            let firstDate = $0.startDate ?? currentDate
            let secondDate = $1.startDate ?? currentDate
            return firstDate > secondDate
        }
        return filteredEvents
        
    }
    
    private func addEventToFavorites(event: Event) {
        favoritesViewController?.bookmarks.append(event)
        showFavoriteAddedAlert(for: event)
        NotificationCenter.default.post(name: .favoriteEventAdded, object: event)

        }
    
    private func showFavoriteAddedAlert(for event: Event) {
        let alertController = UIAlertController(
            title: "Added to Favorites",
            message: "\(event.title)",
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}


// MARK: TableView DataSource & Delegate

extension AllEventsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        
        
        let event = filteredEvents[indexPath.row]
        cell.configure(with: event)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
            let event = filteredEvents[indexPath.row]
            
            let addFavoriteAction = UIContextualAction(style: .normal, title: "Add to Favorites") { (action, view, completionHandler) in
                 self.addEventToFavorites(event: event)
                 tableView.reloadData()
                completionHandler(true)
            }
            
        addFavoriteAction.backgroundColor = UIColor(named: "primaryBlue")
            let configuration = UISwipeActionsConfiguration(actions: [addFavoriteAction])
            return configuration
        }
}

//#Preview { AllEventsViewController() }

extension Notification.Name {
    static let favoriteEventAdded = Notification.Name("favoriteEventAdded")
}
