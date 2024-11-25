//
//  ModelEvent.swift
//  URL
//
//  Created by vp.off on 21.11.2024.
//

import Foundation
/*
struct Event {
    let id: Int
    let title: String
    let description: String
    let bodyText: String
    let categories: [String]
    let price: String
    let images: [String]
    let favoritesCount: Int
    let startDate: Int?
    let endDate: Int?   
    let locationSlug: String?
    let placeId: Int?

    init(from result: Result) {
        self.id = result.id
        self.title = result.title ?? "Default title"
        self.description = result.description ?? "Default description"
        self.bodyText = result.bodyText ?? "Default bodyText"
        self.categories = result.categories
        self.price = result.price ?? ""
        self.images = result.images.map { $0.image ?? "Default image" } // Коллекция URL изображений
        self.favoritesCount = result.favoritesCount ?? 0

        // Берем первую дату из массива 'dates'
        if let firstDateElement = result.dates.first {
            self.startDate = firstDateElement.start
            self.endDate = firstDateElement.end
        } else {
            self.startDate = nil
            self.endDate = nil
        }

        // Получаем slug местоположения и id места
        self.locationSlug = result.location.slug?.rawValue ?? ""
        self.placeId = result.place?.id
    }
}
