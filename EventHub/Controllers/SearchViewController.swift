//
//  SearchViewController.swift
//  EventHub
//
//  Created by Anna Melekhina on 22.11.2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let date = Date()
    
    private let labelEmpty = UILabel()
    
    var events: [EventModel] = [
        EventModel(date: "1698764400", title: "Jo Malone London's Mother's", place: "Santa Cruz, CA", imageName: "girlimage"),
        EventModel(date: "1732027600", title: "International Kids Safe Parents Night Out", place: "Oakland, CA", imageName: "girlimage"),
        EventModel(date: "1698850800", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
        EventModel(date: "1732017600", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
        EventModel(date: "1698850800", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
        EventModel(date: "1732017600", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
        EventModel(date: "1698850800", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
        EventModel(date: "1698764400", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage")
    ]
    
    
    
    // MARK: Lifecycle ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        self.hidesBottomBarWhenPushed = false
        
        setupUI()
        updateUI(with: events)
        setupUIEmpty()
        
        //в ТАббаре тоже появляется подпись,которой быть не должно
        
        self.title = "Search"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavCell.self, forCellReuseIdentifier: "FavCell")
        
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        self.tabBarController?.tabBar.isHidden = false
    //
    //    }
    
    
    private func setupUI() {
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
    
    
    
    private func configureLabelEmpty() {
        let labelEmpty = UILabel()
        labelEmpty.text = "NO FAVORITES"
        labelEmpty.font = UIFont.boldSystemFont(ofSize: 30)
        labelEmpty.textColor = .black
        labelEmpty.translatesAutoresizingMaskIntoConstraints = false
        view.addArrangedSubview(labelEmpty)
    }
    
    private func setupUIEmpty() {
        
        configureLabelEmpty()
        
        NSLayoutConstraint.activate([
            
            emptyStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStack.widthAnchor.constraint(equalToConstant: 300),
            emptyStack.heightAnchor.constraint(equalToConstant: 250)
            
        ])
    }
    
    private func updateUI(with events: [EventModel]) {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearchButton))
        
        
        if events.isEmpty {
            DispatchQueue.main.async {
                self.labelEmpty.isHidden = false
                self.tableView.isHidden = true
                self.view.bringSubviewToFront(self.labelEmpty)
            }
        } else {
            self.events = bookmarks
            DispatchQueue.main.async {
                
                self.labelEmpty.isHidden = true
                self.tableView.isHidden = false
                self.tableView.reloadData()
                
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
    
    @objc private func didTapSearchButton() {
        print("Search")
        
    }
}


// MARK: TableView DataSource & Delegate

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return events.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath) as! FavCell
        let event = events[indexPath.row]
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
        //        }
        
        
    }
}


#Preview { SearchViewController() }



}
