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
    case education = "education"
    case entertainment = "entertainment"
    case exhibitions = "exhibition"
    case fashionAndStyle = "fashion"
    case festivals = "festival"
    case holidays = "holiday"
    case kids = "kids"
    case other = "other"
    case parties = "party"
    case photography = "photo"
    case quests = "quest"
    case sports = "recreation"
    case shopping = "shopping"
    case charity = "social-activity"
    case promotions = "stock"
    case theater = "theater"
    case tours = "tour"
    case fairs = "yarmarki-razvlecheniya-yarmarki"

    var fullName: String {
           switch self {
           case .business:
               return "Business"
           case .cinema:
               return "Cinema"
           case .concerts:
               return "Concerts"
           case .education:
               return "Education"
           case .entertainment:
               return "Entertainment"
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
           case .photography:
               return "Photography"
           case .quests:
               return "Quests"
           case .sports:
               return "Sports"
           case .shopping:
               return "Shopping"
           case .charity:
               return "Charity"
           case .promotions:
               return "Promotions"
           case .theater:
               return "Theater"
           case .tours:
               return "Tours"
           case .fairs:
               return "Fairs"
           }
       }
}
