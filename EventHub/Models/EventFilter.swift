//
//  EventFilter.swift
//  EventHub
//
//  Created by Anna Melekhina on 25.11.2024.
//

import Foundation

struct EventFilter {
    var dates: String?
    var location: City?
    var categories: Category?
    var actualSince: String?   
    var actualUntil: String?
}
