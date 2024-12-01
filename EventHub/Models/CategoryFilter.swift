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
    case kids = "kids"
    case parties = "party"
 

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

           case .kids:
               return "Kids"
           case .parties:
               return "Parties"
         
           }
       }
    
    var iconName: String {
            switch self {
            case .sports: return "basketball"
            case .business: return "bubble.left.and.bubble.right"
            case .cinema: return "film"
            case .music: return "music.note"
            case .art: return "paintpalette"
            case .kids: return "figure.2.and.child.holdinghands"
            case .parties: return "figure.dance"
            }
        }
    
    var iconAsset: String {
            switch self {
            case .sports: return "sports"
            case .business: return "art"
            case .cinema: return "art"
            case .music: return "music"
            case .art: return "art"
            case .kids: return "sports"
            case .parties: return "music"
            }
        }
}

func chooseCategory(for string: String) -> Category {
    switch string {
    case "Sports":
        return .sports
    case "Music":
        return .music
    case "Art":
        return .art
    case "Business":
        return .business
    case "Cinema":
        return .cinema
    case "Kids":
        return .kids
    case "Parties":
        return .parties

    default:
        return .art
    }
}

//получаем иконку соответвующую названию
func geticonName(for categoryName: String) -> String? {
     if let category = Category.allCases.first(where: { $0.fullName.lowercased() == categoryName.lowercased() }) {
        return category.iconName
    }
    return nil
}

func getIconForCategory(for categories: [String]) -> String {
    for categoryName in categories {
        if let category = Category.allCases.first(where: {
            $0.fullName.caseInsensitiveCompare(categoryName) == .orderedSame
        }) {
            return category.iconAsset
        }
    }
    return Category.art.iconAsset
}
