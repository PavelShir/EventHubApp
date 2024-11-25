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
        let dates: [DateElement]
        let title, slug: String?
        let place: Place?
        let description, bodyText: String?
        let location: Location
        let categories: [String]
        let price: String?
        let images: [Image]
        let favoritesCount: Int?


        enum CodingKeys: String, CodingKey {
            case id, dates, title, slug, place, description
            case bodyText = "body_text"
            case location, categories, price, images
            case favoritesCount = "favorites_count"
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
    }

    enum Name: String, Codable {
        case empty = ""
        case moscowseasonsCOM = "moscowseasons.com"
        case shutterstockCOM = "shutterstock.com"
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
