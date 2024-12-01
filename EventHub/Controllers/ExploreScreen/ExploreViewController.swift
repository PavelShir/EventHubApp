//
//  ExploreScreen.swift
//  MyEventHub
//
//  Created by Дмирий Зядик on 18.11.2024.
//

import UIKit
import SwiftUI

class ExploreViewController: UIViewController, FilterDelegate {
    
    
    func didApplyFilters(_ eventFilters: EventFilter) {
        events = []
        filteredEvents = []
        print("eventFilters")
        
        loadEventsSuccess(with: eventFilters) { events in
            // Этот блок будет выполнен после того, как события будут загружены
            self.events = events
            DispatchQueue.main.async {
                self.eventViewController.reloadCollectionView()
            }
        }
                          
        
    }
    
    // MARK: - UI
    
    private var buttonStack = createHorizontalStackViewWithButtons()
    
    private var cityPicker: UIPickerView!
   
    lazy var categoryCollectionView: CategoryCollectionView = {
        let element =  CategoryCollectionView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var eventViewController :EventCollectionView = {
        let element = EventCollectionView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var eventViewController2 :EventCollectionView = {
        let element = EventCollectionView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var headerCustomView: HeaderExploreView = {
        let element =  HeaderExploreView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var upcomingStack : UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .equalSpacing
        
        let text1 = UILabel()
        text1.text = "Upcoming Events"
        text1.font = .systemFont(ofSize: 18)
        
        let text2 = UILabel()
        text2.text = "SeeAll"
        text2.font = .systemFont(ofSize: 14)
        text2.textColor = .gray
        
      //  let gesture = UITapGestureRecognizer(target: self, action:  #selector(exploreButtonTapped))
      //  text2.addGestureRecognizer(gesture)
        
        
        element.addArrangedSubview(text1)
        element.addArrangedSubview(text2)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var nearbyStack : UIStackView = {
//        let element = UIStackView(frame: CGRect(x: 20, y: 560, width: 362, height: 30))
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .equalSpacing
        
        let text1 = UILabel()
        text1.text = "Nearby You"
        text1.font = .systemFont(ofSize: 18)
        
        let text2 = UIButton()
        text2.setTitle("SeeAll", for: .normal) // text = "SeeAll"
        text2.titleLabel?.font = .systemFont(ofSize: 14)
        text2.titleLabel?.textColor = .gray
        text2.translatesAutoresizingMaskIntoConstraints = false
      //  let gesture = UITapGestureRecognizer(target: self, action:  #selector(exploreButtonTapped))
     //   text2.addGestureRecognizer(gesture)
        
        element.addArrangedSubview(text1)
        element.addArrangedSubview(text2)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
   
    
    // MARK: - Variable
    let currentTime = Int(Date().timeIntervalSince1970)
    var eventFilters = EventFilter()
    var selectedCity: City?
    var selectedtDate: String!
    var selectedCategory: Category?
    
    var filteredEvents: [Event] = []
    var isSearching: Bool = false
    
    private var events: [Event] = []
    {
        
        didSet {
            eventViewController.configure(e: events, toDetail: goToDetail)
            eventViewController2.configure(e: events, toDetail: goToDetail)
            
            }
    }
    
    var filter = EventFilter()
    private var userCity: City = .moscow
    
    // MARK: - Life Cicle
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        setView()
        setupConstrains()
        
        filter = EventFilter(location: userCity, actualSince: String(1722076800) )  //3 мес назад
        
        
        
        
        
        loadEventsSuccess(with: EventFilter(location: .moscow, actualSince: String(Date().timeIntervalSince1970)), success: loadSuccess)
           
        headerCustomView.filterButton.addTarget(self, action: #selector(filterPressed), for: .touchUpInside)
        
        }
    
    func loadSuccess(e: [Event]) {
        events = e
    }
    
    private func setView(){
        view.backgroundColor =  .gray.withAlphaComponent(0.05)
        headerCustomView.delegate = self
        view.addSubview(headerCustomView)
        view.addSubview(categoryCollectionView)
        view.addSubview(buttonStack)
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        scrollView.addSubview(upcomingStack)
        scrollView.addSubview(eventViewController)
        scrollView.addSubview(nearbyStack)
        scrollView.addSubview(eventViewController2)
  
        
        setupCityPicker()
    }
    
    // MARK: - Actions
    
    @objc private func exploreButtonTapped() {
        
        let allEventsVC = AllEventsViewController()
        
       
        allEventsVC.events = loadEvents(with: filter)
        allEventsVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(allEventsVC, animated: true)
    }
    
    @objc func notificationButtonPressed(){
        
    }
    

    @objc func filterPressed() {
        
        print("pressed Explore")
        let filterVC = FilterViewController()
        filterVC.delegate = self
        filterVC.modalPresentationStyle = .popover
        

        present(filterVC, animated: true)
    }
    
    func goToDetail(with event: Event){
        let eventVC = EventDetailsViewController()
        eventVC.eventDetail = event
        //print("go to event details")
        
        navigationController?.pushViewController(eventVC, animated: true)
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

extension ExploreViewController {
    
    private func setupConstrains(){
        NSLayoutConstraint.activate([
            
            headerCustomView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            headerCustomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            headerCustomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            headerCustomView.heightAnchor.constraint(equalToConstant: 179),
            
            categoryCollectionView.topAnchor.constraint(equalTo: headerCustomView.bottomAnchor, constant: -20),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 40),
            
            //buttonStack
            buttonStack.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 28.32),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonStack.heightAnchor.constraint(equalToConstant: 40),
            
            //scrollView
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 8.0),
                    
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
                    
            
//            upcomingStack
            upcomingStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8.84),
            upcomingStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            upcomingStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            upcomingStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -30),
            upcomingStack.heightAnchor.constraint(equalToConstant: 40),
            
            
//            eventViewController
            eventViewController.topAnchor.constraint(equalTo: upcomingStack.bottomAnchor, constant: 10),
            eventViewController.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            eventViewController.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            eventViewController.heightAnchor.constraint(equalToConstant: 255),
//            nearbyStack
            nearbyStack.topAnchor.constraint(equalTo: eventViewController.bottomAnchor, constant: 10),
            nearbyStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            nearbyStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            nearbyStack.heightAnchor.constraint(equalToConstant: 40),
//            eventViewController2
            eventViewController2.topAnchor.constraint(equalTo: nearbyStack.bottomAnchor, constant: 0),
            eventViewController2.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            eventViewController2.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
//            eventViewController2.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            eventViewController2.heightAnchor.constraint(equalToConstant: 255),
            
            
        ])
    }
}

// MARK: City UIPicker

extension ExploreViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func setupCityPicker() {
        print("setupCityPicker")
        cityPicker = UIPickerView()
        cityPicker.delegate = self
        cityPicker.dataSource = self
        cityPicker.backgroundColor = .white
        cityPicker.translatesAutoresizingMaskIntoConstraints = false
        cityPicker.isHidden = true
        view.addSubview(cityPicker)
        
        NSLayoutConstraint.activate([
            cityPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cityPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cityPicker.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cityPicker.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    @objc func showCityPicker() {
        cityPicker.isHidden = false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return City.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return City.allCases[row].fullName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // выбираем город и устанавливаем в фильтр
        
        let cityChosen = City.allCases[row].fullName
//        locationButton.setTitle(cityChosen, for: .normal)
        headerCustomView.locationLabel.text = cityChosen
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.cityPicker.isHidden = true
        }
        selectedCity = chooseCity(for: cityChosen)
        eventFilters.location = selectedCity
    }
    
}

func createHorizontalStackViewWithButtons() -> UIStackView {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 16
    stackView.alignment = .center
    stackView.distribution = .fillEqually
    
    stackView.addArrangedSubview(createRoundedButton(title: "TODAY"))
    stackView.addArrangedSubview(createRoundedButton(title: "FILMS"))
    stackView.addArrangedSubview(createRoundedButton(title: "LISTS"))
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    return stackView
}

 func createRoundedButton(title: String) -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle(title, for: .normal)
    button.titleLabel?.font = UIFont(name: "AirbnbCerealApp", size: 18)
    button.setTitleColor(.white, for: .normal)
     button.backgroundColor = UIColor(named: "primaryBlue")
    button.layer.cornerRadius = 20
    button.translatesAutoresizingMaskIntoConstraints = false
    button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    return button
}


// MARK: SearchBar Delegate methods
extension ExploreViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Если строка поиска пуста, показываем все события
                if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
                    isSearching = false
                    filteredEvents = events
                   
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
       // updateUI()
      }

        
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
          searchBar.resignFirstResponder()
      }
      
      func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
          isSearching = false
             searchBar.text = ""
             filteredEvents = events
             searchBar.resignFirstResponder()
            // updateUI()
      }
        
    }

struct ViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ExploreViewController().showPreview()
    }
}


extension UIViewController {
    private struct Preview : UIViewControllerRepresentable {
        let viewController: UIViewController
        
        
        func makeUIViewController(context: Context) -> some UIViewController {
            viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
    
    func showPreview() -> some View {
        Preview(viewController: self).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
    
}

