//
//  EventFilter.swift
//  EventHub
//
//  Created by Anna Melekhina on 25.11.2024.
//

struct EventFilter {
    var dates: String?
    var title: String?
    var slug: String?
    var place: String?
    var description: String?
    var bodyText: String?
    var location: String?
    var categories: String?
    var images: String?
    var participants: String?
}

final class EventFilterManager {
    static let shared = EventFilterManager()
    
    private init() {}  

    var filters = EventFilter()
}
