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
       // events = []
      //  filteredEvents = []
        print("eventFilters")
        
//        loadEventsSuccess(with: eventFilters) { events in
//            // Этот блок будет выполнен после того, как события будут загружены
//            self.events = events
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
                          
        
    }
    
    
    
    // MARK: - UI
    
    private var cityPicker: UIPickerView!
   
    lazy var categoryCollectionView: CategoryCollectionView = {
        let element =  CategoryCollectionView(frame: CGRect(x: 0, y: 190, width: 402, height: 39))
        return element
    }()
    
    private lazy var eventViewController :EventCollectionView = {
        let element = EventCollectionView(frame: CGRect(x: 20, y: 290, width: 402, height: 255))
        
        return element
    }()
    
    private lazy var eventViewController2 :EventCollectionView = {
        let element = EventCollectionView(frame: CGRect(x: 20, y: 595, width: 402, height: 255))
        
        return element
    }()
    
    lazy var headerCustomView: HeaderExploreView = {
        let element =  HeaderExploreView(frame: CGRect(x: 0, y: 0, width: 402, height: 210))
        return element
    }()
    
    private lazy var upcomingStack : UIStackView = {
        let element = UIStackView(frame: CGRect(x: 20, y: 250, width: 362, height: 30))
        
        element.axis = .horizontal
        element.distribution = .equalSpacing
        
        let text1 = UILabel()
        text1.text = "Upcoming Events"
        text1.font = .systemFont(ofSize: 18)
        
        let text2 = UILabel()
        text2.text = "SeeAll"
        text2.font = .systemFont(ofSize: 14)
        text2.textColor = .gray
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(exploreButtonTapped))
        text2.addGestureRecognizer(gesture)
        
        
        element.addArrangedSubview(text1)
        element.addArrangedSubview(text2)
        
        return element
    }()
    
    private lazy var nearbyStack : UIStackView = {
        let element = UIStackView(frame: CGRect(x: 20, y: 560, width: 362, height: 30))
        
        element.axis = .horizontal
        element.distribution = .equalSpacing
        
        let text1 = UILabel()
        text1.text = "Nearby You"
        text1.font = .systemFont(ofSize: 18)
        
        let text2 = UILabel()
        text2.text = "SeeAll"
        text2.font = .systemFont(ofSize: 14)
        text2.textColor = .gray
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(exploreButtonTapped))
        text2.addGestureRecognizer(gesture)
        
        element.addArrangedSubview(text1)
        element.addArrangedSubview(text2)
        
        return element
    }()
   
    
    // MARK: - Variable
    
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
            
        }
    
    func loadSuccess(e: [Event]) {
        events = e
    }
    
    private func setView(){
        view.backgroundColor =  .white
        headerCustomView.delegate = self
        // view.addSubview(headerView)
        //headerView.addSubview(headerStack)
        view.addSubview(headerCustomView)
        view.addSubview(categoryCollectionView)
        view.addSubview(upcomingStack)
        view.addSubview(eventViewController)
       // view.addSubview(eventCardView)
        view.addSubview(nearbyStack)
        view.addSubview(eventViewController2)
        
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

}

extension ExploreViewController {
    
    private func setupConstrains(){
        NSLayoutConstraint.activate([
            
          
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.cityPicker.isHidden = true
        }
//        selectedCity = chooseCity(for: cityChosen)
//        eventFilters.location = selectedCity
    }
    
}

//struct ViewControllerProvider: PreviewProvider {
//    static var previews: some View {
//        ExploreViewController().showPreview()
//    }
//}
//
//
//extension UIViewController {
//    private struct Preview : UIViewControllerRepresentable {
//        let viewController: UIViewController
//        
//        
//        
//        func makeUIViewController(context: Context) -> some UIViewController {
//            viewController
//        }
//        
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//            
//        }
//    }
//    
//    func showPreview() -> some View {
//        Preview(viewController: self).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//    }
//    
//}

