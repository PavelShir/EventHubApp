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
    
    private init() {}
    
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

