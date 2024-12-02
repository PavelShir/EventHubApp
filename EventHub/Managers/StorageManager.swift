//
//  StorageManager.swift
//  EventHub
//
//  Created by Anna Melekhina on 26.11.2024.
//

import Foundation

final class StorageManager {
    static let shared = StorageManager()
    
    private let storageKey = "bookmarks"
    private let cityKey = "selectedCity"
    
    private init() {}
    
    func loadSelectedCity() -> City {
        if let storedCityRawValue = UserDefaults.standard.string(forKey: cityKey),
           let city = City(rawValue: storedCityRawValue) {
            return city
        } else {
            return .moscow
        }
    }
    
    func saveSelectedCity(_ city: City) {
            UserDefaults.standard.set(city.rawValue, forKey: cityKey)
        }
    
    func loadFavorite() -> [Event] {
        if let favoriteEvents = UserDefaults.standard.data(forKey: storageKey),
           let events = try? JSONDecoder().decode([Event].self, from: favoriteEvents) {
            return events
        }
        return []
    }
    
    func saveFavorites(_ events: [Event]) {
        if let encodedEvents = try? JSONEncoder().encode(events) {
            UserDefaults.standard.set(encodedEvents, forKey: storageKey)
        }
    }
    
    func addFavorite(_ event: Event) {
        var events = loadFavorite()
        events.append(event)
        saveFavorites(events)
    }
    
    // Удаление события из избранного
    func deleteFavorite(_ event: Event) {
        var events = loadFavorite()
        events.removeAll { $0.id == event.id }
        saveFavorites(events)
    }
    
   
    
}

