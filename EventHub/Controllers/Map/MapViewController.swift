//
//  MapViewController.swift
//  EventHub
//
//  Created by Павел Широкий on 18.11.2024.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var cityName: String?
    var mapEvents: [Event] = []
    var places: [Place] = []
    var placeCoordinates: [Coords] = []
    var eventFilter: EventFilter!
    let cell = FavCell()
    
    private let eventInfoTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 10
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOpacity = 0.2
        tableView.layer.shadowOffset = CGSize(width: 0, height: 2)
        tableView.layer.shadowRadius = 5
        tableView.isHidden = true
        return tableView
    }()

    private let currentDate = Int(Date().timeIntervalSince1970)
    private var selectedEvent: Event?
    
    private let categoryCircleView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 220, height: 50)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(cityName: String) {
        self.cityName = cityName
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMap()
        
        mapView.delegate = self
        
        categoryCircleView.delegate = self
        categoryCircleView.dataSource = self
        categoryCircleView.register(MapCollectionCell.self, forCellWithReuseIdentifier: MapCollectionCell.mapIdentifier)
        
        eventInfoTableView.delegate = self
        eventInfoTableView.dataSource = self
        eventInfoTableView.register(FavCell.self, forCellReuseIdentifier: "FavCell")
        
        cell.bookmarkIcon.addTarget(self, action: #selector(addBookmark), for: .touchUpInside)
        
        //        var cityNamee = chooseCity(for: "Kazan")
        
        //делаем фильтр и загржаем события
        eventFilter = EventFilter(location: .moscow, actualSince: String(currentDate))
        loadEventsSuccess(with: eventFilter) { (events: [Event]) in
            DispatchQueue.main.async {
                self.mapEvents = events
                print(self.mapEvents)
                self.processEvents()
                self.loadMapEvents()
            }
        }

        
        
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(mapView)
        view.addSubview(eventInfoTableView)
        
        
        eventInfoTableView.translatesAutoresizingMaskIntoConstraints = false
        categoryCircleView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        view.addSubview(categoryCircleView)
        NSLayoutConstraint.activate([
            categoryCircleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            categoryCircleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1),
            categoryCircleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1),
            categoryCircleView.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
               eventInfoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               eventInfoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
               eventInfoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
               eventInfoTableView.heightAnchor.constraint(equalToConstant: 130)
           ])
        
    }
    
    @objc private func addBookmark() {
        
        if cell.bookmarkIcon.image(for: .normal) == UIImage(systemName: "bookmark") {
            cell.bookmarkIcon.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
               
               var favorites = StorageManager.shared.loadFavorite()
               
            if favorites.contains(where: { $0.id == selectedEvent?.id }) {
                showAlreadyInFavoritesAlert(for: selectedEvent!)
               } else {
                   favorites.append(selectedEvent!)
                   StorageManager.shared.saveFavorites(favorites)
                   showFavoriteAddedAlert(for: selectedEvent!)
                   
                   NotificationCenter.default.post(name: .favoriteEventAdded, object: selectedEvent!)
               }
           } else {
               // Если иконка уже заполненная, это значит событие в избранном, убираем его
               cell.bookmarkIcon.setImage(UIImage(systemName: "bookmark"), for: .normal)
               
               var favorites = StorageManager.shared.loadFavorite()
               
               if let index = favorites.firstIndex(where: { $0.id == selectedEvent?.id }) {
                   favorites.remove(at: index)
                   StorageManager.shared.saveFavorites(favorites)
                    
               }
           }
       }
    
    private func showFavoriteAddedAlert(for event: Event) {
        let alertController = UIAlertController(
            title: "Added to Favorites",
            message: "\(event.title)",
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    private func showAlreadyInFavoritesAlert(for event: Event) {
        let alertController = UIAlertController(
            title: "Already in Favorites!",
            message: "\(event.title)",
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    func processEvents() {
        let dispatchGroup = DispatchGroup()
        
        for event in mapEvents {
            guard let placeId = event.placeId else { continue }
            
            dispatchGroup.enter()
            
            loadPlace(placeId: placeId) { [weak self] place in
                if let place = place, let coords = place.coords {
                    print("координаты для места: \(place.title), lat: \(coords.lat ?? 0), lon: \(coords.lon ?? 0)")
                    
                    // Добавляем место в массив places
                    self?.places.append(place)
                    
                    // Добавляем координаты в массив
                    self?.placeCoordinates.append(coords)
                    
                    // Добавляем пин для события
                    self?.addPinForEvent(event)
                } else {
                    print("Ошибка: Нет координат для места с placeId: \(placeId)")
                }
                dispatchGroup.leave()
            }
        }
    }
        
        
        func setupMap() {
            guard let cityName = cityName else {
                print("Нет данных о городе")
                return
            }
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(cityName) { placemarks, error in
                if let error = error {
                    print(error.localizedDescription)
                    
                } else {
                    
                    if let placemark = placemarks?.first, let location = placemark.location {
                        let coordinate = location.coordinate
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = coordinate
                        annotation.title = self.cityName
                        self.mapView.addAnnotation(annotation)
                        
                        self.setMapRegion(center: location, radius: 10000)
                    }
                }
            }
        
    }
    
        func addPinForEvent(_ event: Event) {
            // Находим место по placeId
            guard let place = places.first(where: { $0.id == event.placeId }) else { return }

            guard let lat = place.coords?.lat, let lon = place.coords?.lon else { return }

            let iconName = getIconForCategory(for: event.categories)
            
            
            // Создаем аннотацию для события
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            let eventAnnotation = EventAnnotation(
                coordinate: coordinate,
                title: event.title,
                categoryIcon: UIImage(named: iconName)
            )

            // Добавляем аннотацию на карту
            mapView.addAnnotation(eventAnnotation)
        }
    
    
    
      func setMapRegion(center: CLLocation, radius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegion(
            center: center.coordinate,
            latitudinalMeters: radius,
            longitudinalMeters: radius
        )
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    
    private func showEventInfoTable() {
        eventInfoTableView.isHidden = false
        eventInfoTableView.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            self.eventInfoTableView.alpha = 1
        }
    }
    
}
    
    
    
    //extension MapViewController: CLLocationManagerDelegate {
    //
    //    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //        if let location = locations.last {
    //            locationManager.stopUpdatingLocation()
    //            let lat = location.coordinate.latitude
    //            let lon = location.coordinate.longitude
    //
    //            weatherManager.fetchWeather(latitude: lat, longitude: lon)
    //        }
    //    }
    //
    //    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    //        print(error)
    //    }
    //}
    
    // MARK: - UICollectionView Delegate & DataSource
    
    extension MapViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return Category.allCases.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MapCollectionCell.mapIdentifier,
                for: indexPath
            ) as? MapCollectionCell else {
                return UICollectionViewCell()
            }
            
            let category = Category.allCases[indexPath.item]
            cell.configure(with: category)
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            guard let cell = collectionView.cellForItem(at: indexPath) as? MapCollectionCell else {
                return
            }
            let selectedCategory = chooseCategory(for: cell.titleLabel.text ?? "Other")
            print(selectedCategory)
            //        eventFilters.categories = selectedCategory
        }
        
        
        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCircleCell else {
                return
            }
            
            if let category = cell.titleLabel.text {
                //                eventFilters.categories = nil
            }
        }
    }

    
    extension MapViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 220, height: 50)
        }
        
    }
    
    // MARK: MapDelegate
    extension MapViewController: MKMapViewDelegate {
        
        func loadMapEvents() {
            // Пример загрузки событий (если события уже получены в массиве mapEvents)
            for event in mapEvents {
                   // Ищем место по placeId события
                   guard let place = places.first(where: { $0.id == event.placeId }) else { continue }
                   guard let coords = place.coords else { continue }

                   // Создаем аннотацию для каждого события
                   let eventAnnotation = EventAnnotation(
                       coordinate: CLLocationCoordinate2D(latitude: coords.lat ?? 0, longitude: coords.lon ?? 0),
                       title: event.title,
                       categoryIcon: UIImage(named: "map.fill")
                   )

                   // Добавляем аннотацию на карту
                   mapView.addAnnotation(eventAnnotation)
               }
           }
        
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let eventAnnotation = annotation as? EventAnnotation else { return nil }
            
            let identifier = "EventAnnotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//                annotationView?.canShowCallout = true // Для отображения всплывающей информации
            } else {
                annotationView?.annotation = annotation
            }
            
            annotationView?.image = eventAnnotation.categoryIcon
            
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let eventAnnotation = view.annotation as? EventAnnotation else { return }
                    
                    if let eventTitle = eventAnnotation.title,
                       let event = mapEvents.first(where: { $0.title == eventAnnotation.title }) {
                        selectedEvent = event
                        print(selectedEvent)
                        eventInfoTableView.reloadData()
                        showEventInfoTable() } else {
                            print("Event not found for title: \(eventAnnotation.title ?? title)")
                        }
                    
        }
        
        func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
            hideEventInfoTable()
        }

        private func hideEventInfoTable() {
           
                self.eventInfoTableView.alpha = 0
                self.eventInfoTableView.isHidden = true
                self.selectedEvent = nil
            }
    }
    
    
    // MARK: - Custom Annotation Class
    class EventAnnotation: NSObject, MKAnnotation {
        var coordinate: CLLocationCoordinate2D
        var title: String?
        var categoryIcon: UIImage?
        
        init(coordinate: CLLocationCoordinate2D, title: String?, categoryIcon: UIImage?) {
            self.coordinate = coordinate
            self.title = title
            self.categoryIcon = categoryIcon
        }
    }
    
    //MARK: Tableview delegate,datasourse

extension MapViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedEvent == nil ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath) as? FavCell,
              let event = selectedEvent else { return UITableViewCell() }
        
        cell.configure(with: event)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // переход на Ивент + передать данные об ивенте
        
                let place = places[indexPath.row]
                let eventVC = EventDetailsViewController()
                eventVC.eventDetail = selectedEvent
        
                    navigationController?.pushViewController(eventVC, animated: true)
                    tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    
}

    #Preview {MapViewController(cityName: "kazan") }
