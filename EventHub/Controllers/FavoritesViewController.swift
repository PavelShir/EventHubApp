//
//  FavoritesViewController.swift
//  EventHub
//
//  Created by Павел Широкий on 18.11.2024.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    
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
    
    var bookmarks: [EventModel] = [
        EventModel(date: "1698764400", title: "Jo Malone London's Mother's", place: "Santa Cruz, CA", imageName: "girlimage"),
        EventModel(date: "1732027600", title: "International Kids Safe Parents Night Out", place: "Oakland, CA", imageName: "girlimage"),
        EventModel(date: "1698850800", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "AppIcon"),
        EventModel(date: "1732017600", title: "Jo Malone London's banana's International Kids", place: "Santa Cruz, CA", imageName: "noEvent"),
        EventModel(date: "1698850800", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, banana", imageName: "girlimage"),
        EventModel(date: "1732017600", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
        EventModel(date: "1698850800", title: "Jo Malone London's Mother's Banana Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
        EventModel(date: "1698764400", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage")
    ]
    
    
    
    // MARK: Lifecycle ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.hidesBottomBarWhenPushed = false
        
        setupUI()
        updateUI(with: bookmarks)
        setupUIEmpty()
        
        //в ТАббаре тоже появляется подпись,которой быть не должно
        
        self.title = "Favorites"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavCell.self, forCellReuseIdentifier: "FavCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    
    private func setupUI() {
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
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
    
    private func updateUI(with bookmarks: [EventModel]) {
        
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
//        searchVC.source = "Favorites"
        searchVC.events = bookmarks
        navigationController?.pushViewController(searchVC, animated: true)
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
            bookmarks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // переход на Ивент + передать данные об ивенте
        
        //        let selectedEvent = eventData[indexPath.row]
        //        let eventVC = Explore()
        //        eventVC.event = selectedEvent
        //
        //            navigationController?.pushViewController(eventVC, animated: true)
        //            tableView.deselectRow(at: indexPath, animated: true)
        //        }
        
        
    }
}


//#Preview { FavoritesViewController() }
