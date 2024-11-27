//
//  HTTPClient.swift
//  
//
//  Created by vp.off on 22.11.2024.
//
import Foundation

var events: [Event] = []
var filters = EventFilter()

let currentTimestamp = Int(Date().timeIntervalSince1970)

//let urlEvent = URL(string: "https://kudago.com/public-api/v1.4/events/?fields=id,dates,title,slug,place,description,body_text,location,categories,price,images,favorites_count&text_format=text")


func createURL(with filters: EventFilter,
               actualSince: String? = nil,
               actualUntil: String? = nil) -> URL? {
      var components = URLComponents(string: "https://kudago.com/public-api/v1.4/events/")
      
      components?.queryItems = [
          URLQueryItem(name: "fields", value: "id,dates,title,slug,place,description,location,categories,images,favorites_count"),
          URLQueryItem(name: "text_format", value: "text"),
          URLQueryItem(name: "page_size", value: "35") //максимальное число объектов в массиве
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

func loadEventsSuccess(with filters: EventFilter, success: (([Event]) -> Void)? = nil)  {
    Task {
        do {
            events = try await fetchEvent(with: filters)
            success?(events)
            //print(events) // Или ваша функция вывода данных
        } catch {
            print("Error fetching events: \(error.localizedDescription)")
        }
    }
    
   // return events
}

//func testJsonText() {
//    for event in events {
//        print(event)
//    }
//}

struct Event: Codable, Equatable {
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

        // выбираем дату из массива
        let processedDates = processDates(dates: result.dates, currentTimestamp: currentTimestamp)
        self.startDate = processedDates.startDate
        self.endDate = processedDates.endDate

        self.locationSlug = result.location.slug?.rawValue ?? ""
        self.placeId = result.place?.id
    }
}

// функция для обработки массива дат. Получаем 1 дату из массива
private func processDates(dates: [DateElement], currentTimestamp: Int) -> (startDate: Int?, endDate: Int?) {
    let threeMonthsAgoTimestamp = 1722076800

    let validDates = dates.map { date -> DateElement in
        // Заменяем некорректные даты текущей датой
        if let start = date.start, start == -62135433000 {
            return DateElement(start: currentTimestamp, end: date.end ?? currentTimestamp)
        }
        return date
    }
        .filter { date in
                // Убираем даты старше 3 месяцев от текущей даты
                if let start = date.start {
                    return start >= threeMonthsAgoTimestamp
                }
                return false
            }

    // Определяем ближайшую будущую или ближ последнюю дату
    if let nearestFutureDate = validDates.first(where: { $0.start ?? 0 >= currentTimestamp }) {
        return (startDate: nearestFutureDate.start, endDate: nearestFutureDate.end)
    }
    if let nearestPastDate = validDates.last(where: { $0.end ?? 0 < currentTimestamp }) {
        return (startDate: nearestPastDate.start, endDate: nearestPastDate.end)
    }
 
    return (startDate: currentTimestamp, endDate: currentTimestamp)
}


    // MARK: Загрузка информации о месте по айди

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

