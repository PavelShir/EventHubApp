//
//  HTTPClient.swift
//
//
//  Created by vp.off on 22.11.2024.
//
import Foundation

protocol NetworkManagerDelegate {
    func didUpdateEvent(events: [ModelEvent])
    func didFailWithError(error: Error)
}

struct NetworkManager {
    
    var delegate: NetworkManagerDelegate?
    
    var events: [ModelEvent] = []
    let filters = EventFilterManager.shared.filters
    
    //    let urlEvent = URL(string: "https://kudago.com/public-api/v1.4/events/?fields=id,dates,title,slug,place,description,body_text,location,categories,price,images,favorites_count&text_format=text")
    
    func createURL(with filters: EventFilter) -> URL? {
        var components = URLComponents(string: "https://kudago.com/public-api/v1.4/events/")
        
        components?.queryItems = [
            URLQueryItem(name: "fields", value: "id,dates,title,slug,place,description,body_text,location,categories,price,images,favorites_count"),
            URLQueryItem(name: "text_format", value: "text")
        ]
        
        if let location = filters.location {
            components?.queryItems?.append(URLQueryItem(name: "location", value: location))
        }
        if let categories = filters.categories {
            components?.queryItems?.append(URLQueryItem(name: "categories", value: categories))
        }
        
        return components?.url
    }
    
    private func fetchEvent(with filters: EventFilter) async throws -> [ModelEvent] {
        guard let url = createURL(with: filters) else {
            print("Error: Invalid URL")
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Error with Response: \(response)")
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        
        do {
            let eventResponse = try decoder.decode(ResponseEvent.self, from: data)
            return eventResponse.results.map { Event(from: $0) }
        } catch {
            print("Decoding error: \(error.localizedDescription)")
            throw error
        }
        
        return eventResponse.results.map { Event(from: $0) }
    }
    
    // Функция для загрузки событий
    func loadEvents() {
        Task {
            do {
                events = try await fetchEvent(with: filters)
                //                print(events) // Или ваша функция вывода данных
                delegate?.didUpdateEvent(events: events)
                
            } catch {
                delegate?.didFailWithError(error: error)
                print("Error loading events: \(error.localizedDescription)")
            }
        }
    }
    
    func testJsonText() {
        for event in events {
            print(event)
        }
    }
    
    
    
}

//struct Event {
//    let id: Int
//    let title: String
//    let description: String
//    let bodyText: String
//    let categories: [String]
//    let price: String
//    let images: [String]
//    let favoritesCount: Int
//    let startDate: Int?
//    let endDate: Int?
//    let locationSlug: String?
//    let placeId: Int?
//
//    init(from result: Results) {
//        self.id = result.id
//        self.title = result.title ?? "Default title"
//        self.description = result.description ?? "Default description"
//        self.bodyText = result.bodyText ?? "Default bodyText"
//        self.categories = result.categories
//        self.price = result.price ?? ""
//        self.images = result.images.map { $0.image ?? "Default image" } // Коллекция URL изображений
//        self.favoritesCount = result.favoritesCount ?? 0
//
//        // Берем первую дату из массива 'dates'
//        if let firstDateElement = result.dates.first {
//            self.startDate = firstDateElement.start
//            self.endDate = firstDateElement.end
//        } else {
//            self.startDate = nil
//            self.endDate = nil
//        }
//
//        // Получаем slug местоположения и id места
//        self.locationSlug = result.location.slug?.rawValue ?? ""
//        self.placeId = result.place?.id
//    }
//}
