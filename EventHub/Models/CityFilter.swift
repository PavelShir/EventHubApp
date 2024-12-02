//
//  CityFilter.swift
//  EventHub
//
//  Created by Anna Melekhina on 25.11.2024.
//

import Foundation

enum City: String, Codable, CaseIterable {
    case saintPetersburg = "spb"
    case moscow = "msk"
    case yekaterinburg = "ekb"
    case nizhnyNovgorod = "nnv"
    case kazan = "kzn"
   

    var fullName: String {
            switch self {
            case .saintPetersburg:
                return "Saint Petersburg"
            case .moscow:
                return "Moscow"
            case .yekaterinburg:
                return "Yekaterinburg"
            case .nizhnyNovgorod:
                return "Nizhny Novgorod"
            case .kazan:
                return "Kazan"
        }
}
func chooseCity(for city: String) -> City {
    switch city {
    case "Saint Petersburg":
        return .saintPetersburg
    case "Moscow":
        return .moscow
    case "Yekaterinburg":
        return .yekaterinburg
    case "Nizhny Novgorod":
        return .nizhnyNovgorod
    case "Kazan":
        return .kazan
    
    default:
        return .moscow
    }
}


//
//let city = City.moscow
//print("City code: \(city.rawValue)") // Выводит "msk"
//print("City full name: \(city.fullName)") // Выводит "Moscow"
