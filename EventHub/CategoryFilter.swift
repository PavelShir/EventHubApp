//
//  CategoryFilter.swift
//  EventHub
//
//  Created by Anna Melekhina on 25.11.2024.
//

import Foundation

enum Category: String, Codable, CaseIterable {
    case sports = "recreation"
    case music = "concert"
    case art = "exhibition"
    case business = "business-events"
    case cinema = "cinema"
    case fashionAndStyle = "fashion"
    case kids = "kids"
    case parties = "party"
    case other = "other"
  

    var fullName: String {
           switch self {
           case .sports:
              return "Sports"
           case .music:
               return "Music"
           case .art:
               return "Art"
           case .business:
               return "Business"
           case .cinema:
               return "Cinema"
           case .fashionAndStyle:
               return "Fashion"
           case .kids:
               return "Kids"
           case .parties:
               return "Parties"
           case .other:
               return "Other"
           }
       }
    
    var iconName: String {
            switch self {
            case .sports: return "basketball"
            case .business: return "bubble.left.and.bubble.right"
            case .cinema: return "film"
            case .music: return "photo.artframe"
            case .art: return "pencil.and.outline"
            case .fashionAndStyle: return "camera"
            case .kids: return "person.crop.circle"
            case .parties: return "moon.stars.circle"
            case .other: return "binoculars"

            }
        }
}
