//
//  ListsViewController.swift
//  EventHub
//
//  Created by Anna Melekhina on 29.11.2024.
//

import UIKit
import WebKit

class ListsViewController: UIViewController {
    
    var itemsList: [ItemList] = [
        ItemList(title: "kjdsjdsj", siteUrl: "ncxbcs"),
        ItemList(title: "kjdsjdsj", siteUrl: "ncxbcs"),
        ItemList(title: "kjdsjdsj", siteUrl: "ncxbcs")
    ]
    
    private var tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        
        
        
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
            
            let webViewController = WebViewController()
            webViewController.url = URL(string: "https://www.example.com") // передаем URL
            navigationController?.pushViewController(webViewController, animated: true)
            
        }
    }


//#Preview { ListsViewController() }


struct ItemList: Codable {
    let title: String
    let siteUrl: String
    }
