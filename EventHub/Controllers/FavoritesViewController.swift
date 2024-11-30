//
//  FavoritesViewController.swift
//  EventHub
//
//  Created by Павел Широкий on 18.11.2024.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorites"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let date = Date()
    private lazy var emptyStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .equalCentering
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let imageEmpty = UIImageView()
    private let labelEmpty = UILabel()
    private let smallLabelEmpty = UILabel()
    
    private var bookmarks: [Event] = StorageManager.shared.loadFavorite()
    
    
    // MARK: Lifecycle ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.hidesBottomBarWhenPushed = false
        
        
        setupUIEmpty()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setupUI()
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.loadFavorites()
            
            DispatchQueue.main.async {
                self.updateUI(with: self.bookmarks)
            }
        }
        
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavCell.self, forCellReuseIdentifier: "FavCell")
        NotificationCenter.default.addObserver(self, selector: #selector(eventAddedToFavorites(_:)), name: .favoriteEventAdded, object: nil)
        
    }
    
    deinit {
        // Отписка от уведомлений
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        bookmarks = StorageManager.shared.loadFavorite()
        tableView.reloadData()
    }
    
    
    private func setupUI() {
        
        view.addSubview(headerLabel)
       NSLayoutConstraint.activate([
        headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1),
           headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
       ])
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
            
        ])
    }
    
    private func configureImageEmpty() {
        let imageEmpty = UIImageView()
        imageEmpty.image = UIImage(named: "noFav")
        emptyStack.addArrangedSubview(imageEmpty)
        imageEmpty.contentMode = .scaleAspectFit
        imageEmpty.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            imageEmpty.widthAnchor.constraint(equalToConstant: 170),
            imageEmpty.heightAnchor.constraint(equalToConstant: 170)
            
        ])
        
    }
    
    @objc private func eventAddedToFavorites(_ notification: Notification) {
        if let event = notification.object as? Event {
                 if !bookmarks.contains(where: { $0.id == event.id }) {

                     bookmarks.append(event)
                    
                    // Обновляем UI
                    DispatchQueue.main.async {
                        self.updateUI(with: self.bookmarks)
                        self.tableView.reloadData()
                    }
                } else {
                     print("Event is already in favorites: \(event.title)")
                }
            }
    }
    
    private func configureLabelEmpty() {
        let labelEmpty = UILabel()
        labelEmpty.text = "NO FAVORITES"
        labelEmpty.font = UIFont.boldSystemFont(ofSize: 30)
        labelEmpty.textColor = .black
        labelEmpty.translatesAutoresizingMaskIntoConstraints = false
        emptyStack.addArrangedSubview(labelEmpty)
    }
    
    private func setupUIEmpty() {
        
        configureLabelEmpty()
        configureImageEmpty()
        
        NSLayoutConstraint.activate([
            
            emptyStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStack.widthAnchor.constraint(equalToConstant: 300),
            emptyStack.heightAnchor.constraint(equalToConstant: 250)
            
        ])
    }
    
    private func updateUI(with bookmarks: [Event]) {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearchButton))
        
        
        if bookmarks.isEmpty {
            DispatchQueue.main.async {
                self.emptyStack.isHidden = false
                self.tableView.isHidden = true
                self.view.bringSubviewToFront(self.emptyStack)
            }
        } else {
            self.bookmarks = bookmarks
            DispatchQueue.main.async {
                
                self.emptyStack.isHidden = true
                self.tableView.isHidden = false
                self.tableView.reloadData()
                
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
    
    @objc private func didTapSearchButton() {
        
        let searchVC = SearchViewController()
        searchVC.hidesBottomBarWhenPushed = true
        searchVC.events = bookmarks
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    private func loadFavorites() {
        bookmarks = StorageManager.shared.loadFavorite()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}



// MARK: TableView DataSource & Delegate

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath) as! FavCell
        let bookmark = bookmarks[indexPath.row]
        cell.configure(with: bookmark)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let eventToDelete = bookmarks[indexPath.row]
            tableView.performBatchUpdates({
                        bookmarks.remove(at: indexPath.row)
                        StorageManager.shared.deleteFavorite(eventToDelete)
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                    }, completion: nil)
                    
                    if bookmarks.isEmpty {
                        DispatchQueue.main.async {
                            self.updateUI(with: self.bookmarks)
                        }
                    }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // переход на Ивент + передать данные об ивенте
        
        let selectedEvent = bookmarks[indexPath.row]
        let eventVC = EventDetailsViewController()
        eventVC.eventDetail = selectedEvent

            navigationController?.pushViewController(eventVC, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        
    }
}


//#Preview { FavoritesViewController() }
