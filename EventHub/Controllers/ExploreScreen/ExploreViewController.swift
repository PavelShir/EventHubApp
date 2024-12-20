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
            
            self.eventsUpcoming = events
            
            DispatchQueue.main.async {
                self.eventViewController.reloadCollectionView()
            }
        }
        
        loadEventsSuccess(with: EventFilter(location: .moscow, categories: Category.allCases.randomElement()!, actualSince: String(1733758654))) { events in
            self.eventsNearby = events
            DispatchQueue.main.async {
                self.eventViewController2.reloadCollectionView()
            }
        }
        
        
    }
    
    // MARK: - UI
    private let eventCollectionView = EventCollectionView(frame: .zero)
 
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Search..."
        search.translatesAutoresizingMaskIntoConstraints = false
        search.backgroundColor = .clear
        search.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
                    
        search.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        search.searchTextField.backgroundColor = UIColor(named: "darkBlue")
        search.searchTextField.textColor = .white // Устанавливаем цвет текста
        search.searchTextField.tintColor = .white
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
               .foregroundColor: UIColor.white
               ]
               
         search.layer.cornerRadius = 10
        search.clipsToBounds = true
        
        let customImageView = UIImageView(image: UIImage(named: "searchExplore"))
        customImageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        customImageView.contentMode = .scaleAspectFit
        search.searchTextField.leftView = customImageView
        search.searchTextField.leftViewMode = .always
        
        return search
    }()
    
//    let listStackView = createHorizontalStackViewWithButtons()
    let todayButton = createRoundedButton(title: "TODAY")
    let filmsButton = createRoundedButton(title: "FILMS")
    let listsButton = createRoundedButton(title: "LISTS")
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
//    private var buttonStack = createHorizontalStackViewWithButtons()
    
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
        //element.isUserInteractionEnabled = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var searchFilterRow : UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
                
        element.addArrangedSubview(filterButton)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    

     lazy var filterButton : UIButton = {

        let element = UIButton(type: .custom)
         element.backgroundColor = UIColor(named: "darkBlue")
        let imageFilter = UIImage(systemName: "line.horizontal.3.decrease.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        element.setTitle("Filters", for: .normal)
        element.titleLabel?.font = .systemFont(ofSize: 12)
         
        element.layer.cornerRadius = 15
        element.setImage(imageFilter, for: .normal)
        
//        element.addTarget(self, action: #selector(filterPressed), for: .touchUpInside)
        element.isUserInteractionEnabled = true
         
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var currentLocationLabelNotInScroll: UIView = {
        // Основной контейнер, объединяющий текст и значок
        let container = UIStackView()
        container.axis = .horizontal
        container.alignment = .center
        container.spacing = 2
        container.isUserInteractionEnabled = true
        container.translatesAutoresizingMaskIntoConstraints = false

        // Текст
        let label = UILabel()
        label.text = "Current Location"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        label.isUserInteractionEnabled = true

        // Значок
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: "chevron.down")
        iconImageView.tintColor = .white
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 14),
            iconImageView.heightAnchor.constraint(equalToConstant: 14)
        ])

        // Добавление элементов в стек
        container.addArrangedSubview(label)
        container.addArrangedSubview(iconImageView)

        // Жест на основной контейнер
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showCityPicker))
        container.addGestureRecognizer(gesture)

        return container
    }()
    
    private lazy var upcomingStack : UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .equalSpacing
        
        let text1 = UILabel()
        text1.text = "Upcoming Events"
        text1.font = .systemFont(ofSize: 18)
        
        let text2 = UILabel()
        text2.isUserInteractionEnabled = true
        text2.text = "SeeAll"
        text2.font = .systemFont(ofSize: 14)
        text2.textColor = .gray
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(exploreButtonTapped))
        text2.addGestureRecognizer(gesture)
        
        
        element.addArrangedSubview(text1)
        element.addArrangedSubview(text2)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    var currentLocationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Moscow", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont(name: "Arial", size: 14)
        button.setImage(UIImage(named: "Down"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)
        return button
    }()
    
    
    private lazy var nearbyStack : UIStackView = {
        //        let element = UIStackView(frame: CGRect(x: 20, y: 560, width: 362, height: 30))
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .equalSpacing
        
        let text1 = UILabel()
        text1.text = "Nearby You"
        text1.font = .systemFont(ofSize: 18)
        
        let text2 = UILabel()
        text2.isUserInteractionEnabled = true
        text2.text = "SeeAll"
        text2.font = .systemFont(ofSize: 14)
        text2.textColor = .gray
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(exploreButtonTapped))
        text2.addGestureRecognizer(gesture)
        
        element.addArrangedSubview(text1)
        element.addArrangedSubview(text2)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    
    // MARK: - Variable
    let currentTime = Int(Date().timeIntervalSince1970)
    var eventFilters = EventFilter()
    var selectedCity: City?
    var selectedtDate: String!
    var selectedCategory: Category?
    
    var filteredEvents: [Event] = []
    var isSearching: Bool = false
    
    private var eventsUpcoming: [Event] = []
    {
        didSet {
            eventViewController.configure(e: events, toDetail: goToDetail)
            
        }
    }
    
    private var eventsNearby: [Event] = []
    {
        didSet {
            
            eventViewController2.configure(e: eventsNearby, toDetail: goToDetail)
        }
    }
    
    var filter = EventFilter()
    private var userCity: City = .moscow
    
    // MARK: - Life Cicle
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        view.backgroundColor = .white
 
        setView()
        setupScrollView()
        setupContentView()
        setupUIElements()
        view.backgroundColor = .white
        
        searchBar.delegate = self
        categoryCollectionView.delegate = self

        
        currentLocationButton.addTarget(self, action: #selector(showCityPicker), for: .touchUpInside)

        
        filter = EventFilter(location: userCity, actualSince: String(1722076800) )  //3 мес назад
        
        loadEventsSuccess(with: EventFilter(location: .moscow, actualSince: String(1733758654)), success: loadSuccessUpcoming)
        loadEventsSuccess(with: filter, success: loadSuccessNearby)
        
        eventViewController.parentViewController = self
        eventViewController2.parentViewController = self
        
      
        
        todayButton.addTarget(self, action: #selector(showList), for: .touchUpInside)
        filmsButton.addTarget(self, action: #selector(showList), for: .touchUpInside)
        listsButton.addTarget(self, action: #selector(showList), for: .touchUpInside)
        todayButton.tag = 1
        filmsButton.tag = 2
        listsButton.tag = 3

        filterButton.addTarget(self, action: #selector(filterPressed), for: .touchUpInside)
        
        view.bringSubviewToFront(cityPicker)
        view.bringSubviewToFront(todayButton)
        view.bringSubviewToFront(filmsButton)
        view.bringSubviewToFront(listsButton)
        
    }
    
    //скрывает нав бар
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = true
        view.addSubview(scrollView)
        
        
        // Устанавливаем ограничения для scrollView
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
            
        ])
    }
    private func setupContentView() {
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentView)
        
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -65),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupUIElements() {
        
        contentView.addSubview(headerCustomView)
        
        contentView.addSubview(currentLocationLabelNotInScroll)
        contentView.addSubview(currentLocationButton)
        
        contentView.addSubview(searchBar)
        contentView.addSubview(searchFilterRow)
        
        contentView.addSubview(categoryCollectionView)
        contentView.addSubview(todayButton)
        contentView.addSubview(filmsButton)
        contentView.addSubview(listsButton)
        contentView.addSubview(upcomingStack)
        
        contentView.addSubview(eventViewController)
        contentView.addSubview(nearbyStack)
        
        contentView.addSubview(eventViewController2)
        
        
        NSLayoutConstraint.activate([
            headerCustomView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -100),
            headerCustomView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            headerCustomView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            headerCustomView.heightAnchor.constraint(equalToConstant: 340),
            
            // Current Location Label
            currentLocationLabelNotInScroll.topAnchor.constraint(equalTo: headerCustomView.bottomAnchor, constant: -150),
            currentLocationLabelNotInScroll.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            
            // Current Location Button
            currentLocationButton.topAnchor.constraint(equalTo: currentLocationLabelNotInScroll.bottomAnchor, constant: 1),
            currentLocationButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            
            // Search Bar
            searchBar.topAnchor.constraint(equalTo: currentLocationButton.bottomAnchor, constant: 5),
            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: searchFilterRow.leadingAnchor, constant: 30),
            searchBar.heightAnchor.constraint(equalToConstant: 50),

            
            searchFilterRow.topAnchor.constraint(equalTo: currentLocationButton.bottomAnchor, constant: 10),
            searchFilterRow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            searchFilterRow.widthAnchor.constraint(equalToConstant: 60),
            searchFilterRow.heightAnchor.constraint(equalToConstant: 30),
            
        
            // Category Collection View
            categoryCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            categoryCollectionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryCollectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 40),
            categoryCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),

            
            // List Stack View
            todayButton.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 20),
                todayButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                todayButton.widthAnchor.constraint(equalToConstant: 100), // Ширина кнопки
                todayButton.heightAnchor.constraint(equalToConstant: 40), // Высота кнопки
                
                // Films Button
                filmsButton.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 20),
                filmsButton.leadingAnchor.constraint(equalTo: todayButton.trailingAnchor, constant: 20), // Отступ от предыдущей кнопки
                filmsButton.widthAnchor.constraint(equalToConstant: 100), // Ширина кнопки
                filmsButton.heightAnchor.constraint(equalToConstant: 40), // Высота кнопки
                
                // Lists Button
                listsButton.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 20),
                listsButton.leadingAnchor.constraint(equalTo: filmsButton.trailingAnchor, constant: 20), // Отступ от предыдущей кнопки
                listsButton.widthAnchor.constraint(equalToConstant: 100), // Ширина кнопки
                listsButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Upcoming Stack
            upcomingStack.topAnchor.constraint(equalTo: todayButton.bottomAnchor, constant: 20),
            upcomingStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            upcomingStack.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40),
            
            // Event View Controller
            eventViewController.topAnchor.constraint(equalTo: upcomingStack.bottomAnchor, constant: 20),
            eventViewController.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            eventViewController.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40),
            eventViewController.heightAnchor.constraint(equalToConstant: 255),
            
            // Nearby Stack
            nearbyStack.topAnchor.constraint(equalTo: eventViewController.bottomAnchor, constant: 20),
            nearbyStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nearbyStack.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40),
            
            // Event View Controller 2
            eventViewController2.topAnchor.constraint(equalTo: nearbyStack.bottomAnchor, constant: 20),
            eventViewController2.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            eventViewController2.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40),
            eventViewController2.heightAnchor.constraint(equalToConstant: 255),
            eventViewController2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
        ])
        
    }
    
    func loadSuccessUpcoming(e: [Event]) {
        //        events = e
        eventsUpcoming = e
    }
    
    func loadSuccessNearby(e: [Event]) {
        //        events = e
        eventsNearby = e
    }
    
    private func setView(){
        view.backgroundColor =  .gray.withAlphaComponent(0.05)
        view.backgroundColor =  .gray.withAlphaComponent(0.05)
        headerCustomView.delegate = self
        
        setupCityPicker()
    }
    
    
    // MARK: - Actions
    
    @objc private func exploreButtonTapped() {
        print("to all events")
        let allEventsVC = AllEventsViewController()
        allEventsVC.events = loadEvents(with: filter)
        allEventsVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(allEventsVC, animated: true)
    }
    
    
    
    @objc func notificationButtonPressed(){
    }
    
        // Функции подборок
    @objc  func showList(sender: UIButton) {
        
    print("tapped")
        let urlString: String
                   
                   switch sender.tag {
                   case 1:
                       urlString = ListURL.today.urlString
                   case 2:
                       urlString = ListURL.films.urlString
                       print("в фильмах юрл отсутствует в апи. ссылка ведет на постер")
                   case 3:
                       urlString = ListURL.lists.urlString
                   default:
                       urlString = ListURL.today.urlString // ошибка с кнопкой, загрузка событий за сегодня
                   }
                
                 let listVC = ListsViewController()
                
                loadLists(from: urlString) { events in
                    
                    print("API is \(urlString)" )
                    listVC.itemsList = events
                     DispatchQueue.main.async {
                        self.navigationController?.pushViewController(listVC, animated: true)
                         
                    }
                }
            }
    
  
    
    @objc func filterPressed() {
        
        print("pressed Explore")
        let filterVC = FilterViewController()
        filterVC.delegate = self
        filterVC.modalPresentationStyle = .popover
        filterVC.source = .main
        
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
            cityPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                   cityPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                   cityPicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                   cityPicker.heightAnchor.constraint(equalToConstant: 250)
            ])
    }
    
    @objc func showCityPicker() {
        print("tapped")
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
        currentLocationButton.setTitle(cityChosen, for: .normal)
        //  headerCustomView.locationLabel.text = cityChosen
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.cityPicker.isHidden = true
        }
         selectedCity = chooseCity(for: cityChosen)

           // Сохраняем выбранный город в StorageManager
        StorageManager.shared.saveSelectedCity(selectedCity!)

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
        
        guard let searchText = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !searchText.isEmpty else {
            print("Search text is empty")
            return
        }
        let url = "https://kudago.com/public-api/v1.4/search/?q=\(searchText)&expand=&location=\(City.moscow.rawValue)&ctype=event"
        let searchVC = SearchViewController()
        print(url)
        
        loadLists(from: url) { [weak self] events in
            guard let self = self else { return }
            
            // Обновляем UI на главном потоке
            DispatchQueue.main.async {
                if events.isEmpty {
                    print("No events found for search text: \(searchText)")
                } else {
                    searchVC.events = events
                    self.navigationController?.pushViewController(searchVC, animated: true)
                    searchBar.text = ""
                    
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        filteredEvents = events
        searchBar.resignFirstResponder()
        // updateUI()
    }
    
}

//#Preview { ExploreViewController() }


