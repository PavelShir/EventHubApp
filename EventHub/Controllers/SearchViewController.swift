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
    
    private let labelEmpty: UILabel = {
        let labelEmpty = UILabel()
        labelEmpty.text = "NO RESULTS"
        labelEmpty.font = UIFont.boldSystemFont(ofSize: 30)
        labelEmpty.textColor = .black
        labelEmpty.translatesAutoresizingMaskIntoConstraints = false
       return labelEmpty
    }()
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Search..."
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private let filterButton: UIButton = {
        let filterButton = UIButton()
        filterButton.setTitle("Filters", for: .normal)
        filterButton.setTitleColor(.white, for: .normal)
        
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "line.horizontal.3.decrease.circle")
        config.imagePlacement = .leading
        config.imagePadding = 8
        config.cornerStyle = .capsule

        config.baseBackgroundColor = UIColor(named: "primaryBlue")        
        filterButton.configuration = config

        filterButton.translatesAutoresizingMaskIntoConstraints = false
        return filterButton
    }()
         
    
    var events: [EventModel] = []
//        EventModel(date: "1698764400", title: "Jo Malone London's Mother's", place: "Santa Cruz, CA", imageName: "girlimage"),
//        EventModel(date: "1732027600", title: "International Kids Safe Parents Night Out", place: "Oakland, CA", imageName: "girlimage"),
//        EventModel(date: "1698850800", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
//        EventModel(date: "1732017600", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
//        EventModel(date: "1698850800", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
//        EventModel(date: "1732017600", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
//        EventModel(date: "1698850800", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage"),
//        EventModel(date: "1698764400", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "girlimage")
//    ]
    var filteredEvents: [EventModel] = []
    var isSearching: Bool = false
    
    
    // MARK: Lifecycle ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureSearchBar()
        setupTable()
                
        self.title = "Search"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EventCell.self, forCellReuseIdentifier: "EventCell")
        searchBar.delegate = self


    }

    
    
    private func setupTable() {
        
        view.addSubview(labelEmpty)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            
            labelEmpty.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelEmpty.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelEmpty.heightAnchor.constraint(equalToConstant: 191)
            
        ])
    }
    
    
    
    private func configureSearchBar() {
        
        view.addSubview(filterButton)
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            searchBar.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -15),


            filterButton.heightAnchor.constraint(equalToConstant: 44),
            filterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func updateUI(with events: [EventModel]) {
        
        
        if events.isEmpty {
            DispatchQueue.main.async {
                self.labelEmpty.isHidden = false
                self.tableView.isHidden = true
                self.view.bringSubviewToFront(self.labelEmpty)
            }
        } else {
            self.events = events
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
    
    fileprivate func convertDate(date: String) -> String {
        
        guard let timeInterval = Double(date) else {
            return "error invalid Date"
        }
        
        let date = Date(timeIntervalSince1970: timeInterval)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMM d • h:mm a"
        
        return formatter.string(from: date)
    }
    
}


// MARK: TableView DataSource & Delegate

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return isSearching ? filteredEvents.count : events.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        let event = isSearching ? filteredEvents[indexPath.row] : events[indexPath.row]
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

// MARK: SearchBar Delegate methods

extension SearchViewController: UISearchBarDelegate {
    
   
}

#Preview { SearchViewController() }
