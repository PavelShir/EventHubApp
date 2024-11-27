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
        search.backgroundColor = .clear
        
        search.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        search.searchTextField.backgroundColor = .white
        search.layer.cornerRadius = 10
        search.clipsToBounds = true
        
        let customImageView = UIImageView(image: UIImage(named: "search"))
        customImageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        customImageView.contentMode = .scaleAspectFit
        search.searchTextField.leftView = customImageView
        search.searchTextField.leftViewMode = .always
        
        return search
    }()
    
    private let filterButton: UIButton = {
        let filterButton = UIButton()
        filterButton.setTitle("Filters", for: .normal)
        filterButton.setTitleColor(.white, for: .normal)
        
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "line.horizontal.3.decrease.circle.fill")
        config.imagePlacement = .leading
        config.imagePadding = 8
        config.cornerStyle = .capsule

        config.baseBackgroundColor = UIColor(named: "primaryBlue")        
        filterButton.configuration = config

        filterButton.translatesAutoresizingMaskIntoConstraints = false
        return filterButton
    }()
         
    
    var events: [Event] = []
    var filteredEvents: [Event] = []
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
        
        filterButton.addTarget(self, action: #selector(filterPressed), for: .touchUpInside)

    }

    @objc private func filterPressed() {
        let filterVC = FilterViewController()
        filterVC.modalPresentationStyle = .popover
        
        present(filterVC, animated: true)
    }
    
    private func setupTable() {
        
        view.addSubview(labelEmpty)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            
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
            searchBar.heightAnchor.constraint(equalToConstant: 30),
            searchBar.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -15),


            filterButton.heightAnchor.constraint(equalToConstant: 30),
            filterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func updateUI() {
        if isSearching {
               // Поиск активен: показываем "NO RESULTS", если ничего не найдено
               if filteredEvents.isEmpty {
                   DispatchQueue.main.async {
                       self.labelEmpty.isHidden = false
                       self.tableView.isHidden = true
                   }
               } else {
                   DispatchQueue.main.async {
                       self.labelEmpty.isHidden = true
                       self.tableView.isHidden = false
                       self.tableView.reloadData()
                   }
               }
           } else {
               // Поиск не активен: показываем таблицу с событиями, если они есть
               if events.isEmpty {
                   DispatchQueue.main.async {
                       self.labelEmpty.isHidden = false
                       self.tableView.isHidden = true
                   }
               } else {
                   DispatchQueue.main.async {
                       self.labelEmpty.isHidden = true
                       self.tableView.isHidden = false
                       self.tableView.reloadData()
                   }
               }
           }
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
        let selectedEvent = isSearching ? filteredEvents[indexPath.row] : events[indexPath.row] 
        let eventVC = EventDetailsViewController()
        eventVC.eventDetail = selectedEvent

            navigationController?.pushViewController(eventVC, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

// MARK: SearchBar Delegate methods

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Если строка поиска пуста, показываем все события
                if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
                    isSearching = false
                    filteredEvents = events
                    tableView.reloadData()
                    return
                }
        
        filteredEvents.removeAll()
        
        guard searchText != "" || searchText != " " else {
            print("empty search")
            return
        }
        
        
        let lowercasedSearchText = searchText.lowercased()
          filteredEvents = events.filter { event in
              event.title.lowercased().contains(lowercasedSearchText) ||
              convertDate(date: String(event.startDate ?? 0)).lowercased().contains(lowercasedSearchText)
          }
          
          isSearching = true
        updateUI()
      }

        
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
          searchBar.resignFirstResponder()
      }
      
      func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
          isSearching = false
             searchBar.text = ""
             filteredEvents = events
             searchBar.resignFirstResponder()
             updateUI()
      }
        
    }
   


//#Preview { SearchViewController() }
