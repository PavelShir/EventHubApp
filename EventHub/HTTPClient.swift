//
//  HTTPClient.swift
//  
//
//  Created by vp.off on 22.11.2024.
//
import Foundation

var events: [Event] = []
var filters = EventFilter()

//let urlEvent = URL(string: "https://kudago.com/public-api/v1.4/events/?fields=id,dates,title,slug,place,description,body_text,location,categories,price,images,favorites_count&text_format=text")


func createURL(with filters: EventFilter,
               actualSince: String? = nil,
               actualUntil: String? = nil) -> URL? {
      var components = URLComponents(string: "https://kudago.com/public-api/v1.4/events/")
      
      components?.queryItems = [
          URLQueryItem(name: "fields", value: "id,dates,title,slug,place,description,body_text,location,categories,price,images,favorites_count"),
          URLQueryItem(name: "text_format", value: "text")
          
      ]
      
      if let location = filters.location {
          components?.queryItems?.append(URLQueryItem(name: "location", value: location.rawValue))
      }
      if let categories = filters.categories {
          components?.queryItems?.append(URLQueryItem(name: "categories", value: categories.rawValue))
      }
    
    if let actualSince = filters.actualSince {
        components?.queryItems?.append(URLQueryItem(name: "actual_since", value: actualSince))
    }
    
    if let actualUntil = filters.actualUntil {
        components?.queryItems?.append(URLQueryItem(name: "actual_until", value: actualUntil))
    }
   
      return components?.url
  }

private func fetchEvent(with filters: EventFilter) async throws -> [Event] {
    
    guard let url = createURL(with: filters) else {
            throw URLError(.badURL)
        }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw URLError(.badServerResponse)
    }
    
    
    let decoder = JSONDecoder()
    
    do {
        let eventResponse = try decoder.decode(ResponseEvent.self, from: data)
        return eventResponse.results.map { Event(from: $0) }
    } catch let decodingError as DecodingError {
        //  ошибка
        switch decodingError {
        case .typeMismatch(let type, let context):
            print("Type mismatch for type \(type): \(context.debugDescription), codingPath: \(context.codingPath)")
        case .valueNotFound(let type, let context):
            print("Value not found for type \(type): \(context.debugDescription), codingPath: \(context.codingPath)")
        case .keyNotFound(let key, let context):
            print("Key '\(key.stringValue)' not found: \(context.debugDescription), codingPath: \(context.codingPath)")
        case .dataCorrupted(let context):
            print("Data corrupted: \(context.debugDescription), codingPath: \(context.codingPath)")
        @unknown default:
            print("Unknown decoding error")
        }
        throw decodingError
    } catch {
        print("Unknown error: \(error.localizedDescription)")
        throw error
    }
    
}

// Функция для загрузки событий
func loadEvents(with filters: EventFilter) -> [Event]{
    Task {
        do {
            events = try await fetchEvent(with: filters)
            print(events) // Или ваша функция вывода данных
        } catch {
            print("Error fetching events: \(error.localizedDescription)")
        }
    }
    
    return events
}

//func testJsonText() {
//    for event in events {
//        print(event)
//    }
//}

struct Event {
    let id: Int
    let title: String
    let description: String
    let bodyText: String
    let categories: [String]
    let price: String
    let images: String?
    let favoritesCount: Int
    let startDate: Int?
    let endDate: Int?
    let locationSlug: String?
    let placeId: Int?

    init(from result: Results) {
        self.id = result.id
        self.title = result.title ?? "Default title"
        self.description = result.description ?? "Default description"
        self.bodyText = result.bodyText ?? "Default bodyText"
        self.categories = result.categories
        self.price = result.price ?? ""
        
        //берем юрл первую картинку из массива
        self.images = result.images.first?.image ?? ""
        
        self.favoritesCount = result.favoritesCount ?? 0

        // Берем посл дату из массива 'dates'
        if let firstDateElement = result.dates.last {
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

    //Загрузка информации о месте

private func fetchPlace(placeId: Int) async throws -> Place {
    guard let url = URL(string: "https://kudago.com/public-api/v1.4/places/\(placeId)") else {
        throw URLError(.badURL)
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw URLError(.badServerResponse)
    }
    
    let decoder = JSONDecoder()
    
    do {
        let place = try decoder.decode(Place.self, from: data)
        return place  
    } catch {
        print("Decoding error: \(error.localizedDescription)")
        throw error
    }
}

func loadPlace(placeId: Int, completion: @escaping (Place?) -> Void) {
    Task {
        do {
            let place = try await fetchPlace(placeId: placeId)
                        completion(place)
            
        } catch {
            print("Error fetching place: \(error.localizedDescription)")
                        completion(nil)
        }
    }
}

