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
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Events"
        titleLabel.textColor = .label
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        titleLabel.sizeToFit()
        return titleLabel
    }()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        let containerView = UIView()
        containerView.addSubview(titleLabel)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.titleView = containerView
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor)
            ])
        
            NSLayoutConstraint.activate([
                containerView.widthAnchor.constraint(equalToConstant: 200),
                containerView.heightAnchor.constraint(equalToConstant: 44)
            ])
        
        filteredEvents = filterEvents()
        tableView.reloadData()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EventCell.self, forCellReuseIdentifier: "EventCell")
        
        setupBackButton(color: .black, action: #selector(backButtonTapped))
        
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupUI() {
        
        view.backgroundColor = .white
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearchButton))
        searchButton.tintColor = .black
        navigationItem.rightBarButtonItem = searchButton
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
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
        //проверяем, есть ли такая закладка
            var favorites = StorageManager.shared.loadFavorite()
           
            if favorites.contains(where: { $0.id == event.id }) {
                showAlreadyInFavoritesAlert(for: event)
           } else {
                favorites.append(event)
               
                StorageManager.shared.saveFavorites(favorites)
               
                showFavoriteAddedAlert(for: event)
               
                NotificationCenter.default.post(name: .favoriteEventAdded, object: event)
           }
        
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
    
    private func showAlreadyInFavoritesAlert(for event: Event) {
        let alertController = UIAlertController(
            title: "Already in Favorites!",
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // переход на Ивент + передать данные об ивенте
        
                let selectedEvent = filteredEvents[indexPath.row]
                let eventVC = EventDetailsViewController()
                eventVC.eventDetail = selectedEvent
        
                    navigationController?.pushViewController(eventVC, animated: true)
                    tableView.deselectRow(at: indexPath, animated: true)
    }
}

//#Preview { AllEventsViewController() }

extension Notification.Name {
    static let favoriteEventAdded = Notification.Name("favoriteEventAdded")
}
