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
          URLQueryItem(name: "fields", value: "id,dates,title,slug,place,description,location,categories,images,site_url,favorites_count,participants"),
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
    
    print("API URL is \(url)")
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
    let images: String?
    let favoritesCount: Int
    let startDate: Int?
    let endDate: Int?
    let locationSlug: String?
    let placeId: Int?
    let participants: [Participant]
    let siteUrl: String?

    init(from result: Results) {
        self.id = result.id
        self.title = result.title ?? "Default title"
        self.description = result.description ?? "Default description"
        self.bodyText = result.bodyText ?? "Default bodyText"
        self.categories = result.categories ?? []
        
        //берем юрл первую картинку из массива
        self.images = result.images?.first?.image ?? ""
        
        self.favoritesCount = result.favoritesCount ?? 0

        // выбираем дату из массива
        let processedDates = processDates(dates: result.dates ?? [], currentTimestamp: currentTimestamp)
        self.startDate = processedDates.startDate
        self.endDate = processedDates.endDate

        self.locationSlug = result.location?.slug?.rawValue ?? ""
        self.placeId = result.place?.id
        self.participants = result.participants ?? []
        self.siteUrl = result.siteUrl
    }
    
        //это нужно для протокола equatable
    static func ==(lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
        && lhs.title == rhs.title
        && lhs.description == rhs.description
        && lhs.bodyText == rhs.bodyText
        && lhs.categories == rhs.categories
        && lhs.images == rhs.images
        && lhs.favoritesCount == rhs.favoritesCount
        && lhs.startDate == rhs.startDate
        && lhs.endDate == rhs.endDate
        && lhs.locationSlug == rhs.locationSlug
        && lhs.placeId == rhs.placeId
        && lhs.participants == rhs.participants
        && lhs.siteUrl == rhs.siteUrl
    }
    
}

// функция для обработки массива дат. Получаем 1 дату из массива
private func processDates(dates: [DateElement], currentTimestamp: Int) -> (startDate: Int?, endDate: Int?) {
    let threeMonthsAgoTimestamp = 1722076800

    let validDates = dates.map { date -> DateElement in
        // Заменяем некорректные даты текущей датой ?? исправить
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

func fetchPlace(placeId: Int, completion: @escaping (Result<Place, Error>) -> Void) {
    guard let url = URL(string: "https://kudago.com/public-api/v1.4/places/\(placeId)") else {
        completion(.failure(URLError(.badURL)))
        return
    }

    var request = URLRequest(url: url)
    request.timeoutInterval = 16

    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
         if let error = error {
            print("Network error: \(error.localizedDescription)")
            completion(.failure(error))
            return
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            print("Invalid response from server")
            completion(.failure(URLError(.badServerResponse)))
            return
        }

        if httpResponse.statusCode != 200 {
            print("Server error with status code: \(httpResponse.statusCode)")
            completion(.failure(URLError(.badServerResponse)))
            return
        }
        
        guard let data = data else {
            print("No data received")
            completion(.failure(URLError(.badServerResponse)))
            return
        }

        let decoder = JSONDecoder()
        do {
            let place = try decoder.decode(Place.self, from: data)
            completion(.success(place))
        } catch {
            print("Error decoding place data: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }

    task.resume()
}

func fetchPlaceWithRetry(placeId: Int, retryCount: Int = 5, completion: @escaping (Result<Place, Error>) -> Void) {
    fetchPlace(placeId: placeId) { result in
        switch result {
        case .success(let place):
            completion(.success(place))
        case .failure(let error):
            if retryCount > 0 {
                print("Retrying request for placeId: \(placeId), attempts left: \(retryCount)")
                // Пауза между запросами перед повторной попыткой
                DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
                    fetchPlaceWithRetry(placeId: placeId, retryCount: retryCount - 1, completion: completion)
                }
            } else {
                print("All retry attempts failed for placeId: \(placeId). Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}

let queue: OperationQueue = {
    let q = OperationQueue()
    q.maxConcurrentOperationCount = 5
    return q
}()


func fetchAllPlacesWithDelay(placeIds: [Int], delay: TimeInterval = 1.0, completion: @escaping ([Place]) -> Void) {
    let dispatchGroup = DispatchGroup()
    var places: [Place] = []

    for (index, placeId) in placeIds.enumerated() {
        dispatchGroup.enter()
        DispatchQueue.global().asyncAfter(deadline: .now() + Double(index) * delay) {
            fetchPlaceWithRetry(placeId: placeId) { result in
                switch result {
                case .success(let place):
                    places.append(place)
                case .failure:
                    break
                }
                dispatchGroup.leave()
            }
        }
    }

    dispatchGroup.notify(queue: .main) {
        completion(places)
    }
}

func loadPlace(placeId: Int, completion: @escaping (Place?) -> Void) {
    fetchAllPlacesWithDelay(placeIds: [placeId]) { results in
        if let place = results.first(where: { $0 != nil }) as? Place {
            completion(place) // Возвращаем первое успешное место
        } else {
            completion(nil) // Возвращаем nil, если ничего не найдено
        }
    }
}

    // загрузка мест разом
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

func loadPlaceFast (placeId: Int, completion: @escaping (Place?) -> Void) {
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

    // MARK: Загрузка Подборок 

enum ListURL {
    case today
    case films
    case lists
}

extension ListURL {
    var urlString: String {
        switch self {
        case .today:
            return "https://kudago.com/public-api/v1.4/events/?fields=id,dates,title,slug,place,description,location,categories,images,favorites_count,site_url,participants&text_format=text&page_size=35&location=\(City.moscow.rawValue)&actual_since=\(currentTimestamp)&actual_until=\(currentTimestamp)"
        case .films:
            return "https://kudago.com/public-api/v1.4/movies/?actual_since=\(currentTimestamp)"
        case .lists:
            return "https://kudago.com/public-api/v1.2/lists/"
        }
    }
}


func loadLists(from urlString: String, success: (([Event]) -> Void)? = nil)  {
    Task {
        do {
            events = try await fetchEvent(with: urlString)
            success?(events)
         } catch {
            print("Error fetching events: \(error.localizedDescription)")
        }
    }
    }

private func fetchEvent(with urlString: String) async throws -> [Event] {
    print("API URL is \(urlString)")
    
    guard let url = URL(string: urlString) else {
        throw URLError(.badURL)
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw URLError(.badServerResponse)
    }
    
    print(String(data: data, encoding: .utf8) ?? "Invalid JSON")

    let decoder = JSONDecoder()
    
    do {
         let eventResponse = try decoder.decode(ResponseEvent.self, from: data)
        for result in eventResponse.results {
            print("Result siteUrl: \(result.siteUrl ?? "nil")")
        }

         return eventResponse.results.map { Event(from: $0) }
        
        
    } catch let decodingError as DecodingError {
         print("Decoding error: \(decodingError.localizedDescription)")
        
         if case .keyNotFound(let key, let context) = decodingError {
            print("Key not found: \(key), context: \(context.debugDescription)")
        }
        
        throw decodingError
    } catch {
         print("Unknown error: \(error.localizedDescription)")
        throw error
    }
}
