//
//  HTTPClient.swift
//  
//
//  Created by vp.off on 22.11.2024.
//
import Foundation

var events: [Event] = []

let urlEvent = URL(string: "https://kudago.com/public-api/v1.4/events/?fields=id,dates,title,slug,place,description,body_text,location,categories,price,images,favorites_count&text_format=text")

private func fetchEvent() async throws -> [Event] {
    guard let urlEvent else { return [] }
    let (data, response) = try await URLSession.shared.data(from: urlEvent)
    
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw URLError(.badServerResponse)
    }
    
    let decoder = JSONDecoder()
    let eventResponse = try decoder.decode(ResponseEvent.self, from: data)
    return eventResponse.results.map { Event(from: $0) }
}

// Функция для загрузки событий
func loadEvents() {
    Task {
        do {
            events = try await fetchEvent()
            print(events) // Или ваша функция вывода данных
        } catch {
            print("Error fetching events: \(error.localizedDescription)")
        }
    }
}

func testJsonText() {
    for event in events {
        print(event)
    }
}

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
