//
//  ModelEvent.swift
//  URL
//
//  Created by vp.off on 21.11.2024.
//

import UIKit
import Foundation

struct ResponseEvent: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Results]
}

// MARK: - Result
struct Results: Codable {
    let id: Int
    let dates: [DateElement]?
    let title, slug: String?
    let place: Place?
    let description, bodyText: String?
    let location: Location?
    let categories: [String]?
    let images: [Image]?
    let favoritesCount: Int?
    let siteUrl: String?
    let participants: [Participant]?

    
    enum CodingKeys: String, CodingKey {
        case id, dates, title, slug, place, description
        case bodyText = "body_text"
        case location, categories, images
        case favoritesCount = "favorites_count"
        case siteUrl = "site_url"
        case participants
    }
    
    //обработка если проблема с полями при декодировании (отсутствуют)
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.dates = try container.decodeIfPresent([DateElement].self, forKey: .dates) ?? []
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.slug = try container.decodeIfPresent(String.self, forKey: .slug)
        self.place = try container.decodeIfPresent(Place.self, forKey: .place)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.bodyText = try container.decodeIfPresent(String.self, forKey: .bodyText)
        self.location = try container.decodeIfPresent(Location.self, forKey: .location)
        self.categories = try container.decodeIfPresent([String].self, forKey: .categories) ?? []
        self.images = try container.decodeIfPresent([Image].self, forKey: .images) ?? []
        self.favoritesCount = try container.decodeIfPresent(Int.self, forKey: .favoritesCount)
        self.siteUrl = try container.decodeIfPresent(String.self, forKey: .siteUrl)
        self.participants = try container.decodeIfPresent([Participant].self, forKey: .participants) ?? []
    }
    
}

// MARK: - DateElement
struct DateElement: Codable {
    let start, end: Int?
}

// MARK: - Image
struct Image: Codable {
    let image: String?
    let source: Source
}

// MARK: - Source
struct Source: Codable {
    let name: Name?
    let link: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Попытка декодировать значение для name
        let nameValue = try container.decodeIfPresent(String.self, forKey: .name)
        
        if let nameValue = nameValue, let name = Name(rawValue: nameValue) {
            self.name = name
        } else {
            self.name = .empty  // Если строка не распознана, присваиваем значение .empty
            print("Неизвестное значение для имени источника.")
        }
        
        self.link = try container.decodeIfPresent(String.self, forKey: .link)
    }
}

enum Name: String, Codable {
    case empty = ""
    case moscowseasonsCOM = "moscowseasons.com"
    case shutterstockCOM = "shutterstock.com"
    case other = "other"
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        if let validName = Name(rawValue: value) {
            self = validName
        } else {
            self = .other  // Если строка не соответствует известным значениям, ставим "other"
            print("Неизвестное значение для Name: \(value)")
        }
    }
}

// MARK: - Location
struct Location: Codable {
    let slug: Slug?
    let name: String?
    let coords: Coords?
    
}

enum Slug: String, Codable {
    case msk = "Москва"
    case spb = "Петербург"
    case nsk = "Новосибирск"
    case ekb = "Екатеринбург"
    case nnv = "Нижний Новгород"
    case kzn = "Казань"
    case vbg = "Выборг"
    case smr = "Самара"
    case krd = "Краснодар"
    case sochi = "Сочи"
    case ufa = "Уфа"
    case krasnoyarsk = "Красноярск"
    case kev = "Киев"
    case newYork = "Нью-Йорк"
    case unknown = "Неизвестно"
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        // Маппинг для значений, не определённых в перечислении
        switch value {
        case "spb", "saintPetersburg", "petersburg": self = .spb
        case "msk", "moscow": self = .msk
        case "novosibirsk", "nsk": self = .nsk
        case "yekaterinburg", "ekb": self = .ekb
        case "nizhnyNovgorod", "nnv": self = .nnv
        case "kazan", "kzn": self = .kzn
        case "vyborg", "vbg": self = .vbg
        case "samara", "smr": self = .smr
        case "krasnodar", "krd": self = .krd
        case "sochi": self = .sochi
        case "ufa": self = .ufa
        case "krasnoyarsk": self = .krasnoyarsk
        case "kyiv", "kev": self = .kev
        case "newYork", "ny": self = .newYork
        default:
                    // Если значение неизвестно, используем .unknown
                    self = .unknown
        }
    }
}

// MARK: - Place
struct Place: Codable {
    let id: Int
    let title: String?
    let slug: String?
    let address: String?
    let coords: Coords?
    
}

struct Coords: Codable {
    let lat: Double?
    let lon: Double?
}

    //Agent
struct Participant: Codable, Equatable {
    let agent: Agent
}

struct Agent: Codable,Equatable {
    let title: String
}
