//
//  CategoryFilter.swift
//  EventHub
//
//  Created by Anna Melekhina on 25.11.2024.
//

import Foundation

enum Category: String, Codable {
    case business = "business-events"
    case cinema = "cinema"
    case concerts = "concert"
    case exhibitions = "exhibition"
    case fashionAndStyle = "fashion"
    case festivals = "festival"
    case holidays = "holiday"
    case kids = "kids"
    case other = "other"
    case parties = "party"

    var fullName: String {
           switch self {
           case .business:
               return "Business"
           case .cinema:
               return "Cinema"
           case .concerts:
               return "Concerts"
           case .exhibitions:
               return "Exhibitions"
           case .fashionAndStyle:
               return "Fashion"
           case .festivals:
               return "Festivals"
           case .holidays:
               return "Holidays"
           case .kids:
               return "Kids"
           case .other:
               return "Other"
           case .parties:
               return "Parties"
           }
       }
}
