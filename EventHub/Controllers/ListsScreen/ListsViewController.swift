//
//  ListsViewController.swift
//  EventHub
//
//  Created by Anna Melekhina on 29.11.2024.
//

import UIKit
import WebKit

class ListsViewController: UIViewController {
    
    var itemsList: [Event] = []
    
    private var tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Lists"
        setupUI()
        tableView.register(ListCell.self, forCellReuseIdentifier: "ListCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupUI() {
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
}
    extension ListsViewController: UITableViewDelegate, UITableViewDataSource {
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return itemsList.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
            let item = itemsList[indexPath.row]
            cell.setCell(with: item)
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 130
        }
        
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            // переход на Ивент + передать данные об ивенте
            // Web View
            
            let item = itemsList[indexPath.row]
            print(item.siteUrl)
            let webViewController = WebViewController()
            webViewController.url = URL(string: item.siteUrl ?? "https://kudago.com/404")
            navigationController?.pushViewController(webViewController, animated: true)
            
        }
    }


#Preview { ListsViewController() }


