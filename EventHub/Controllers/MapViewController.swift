//
//  MapViewController.swift
//  EventHub
//
//  Created by Павел Широкий on 18.11.2024.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var cityName: String? = "Saint Petersburg"
    
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMap()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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

#Preview {MapViewController() }
