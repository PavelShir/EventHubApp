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
    
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMap()
        
        categoryCircleView.delegate = self
        categoryCircleView.dataSource = self
        categoryCircleView.register(MapCollectionCell.self, forCellWithReuseIdentifier: MapCollectionCell.mapIdentifier)

//        let cityFilter = EventFilter(location: cityName)
//        loadEventsSuccess(with: cityFilter)

        
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(mapView)
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
        
    }
    
    private func setupMap() {
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
    
    
    private func setMapRegion(center: CLLocation, radius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegion(
            center: center.coordinate,
            latitudinalMeters: radius,
            longitudinalMeters: radius
        )
        mapView.setRegion(coordinateRegion, animated: true)
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





#Preview {MapViewController(cityName: "kazan") }
