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
    case novosibirsk = "nsk"
    case yekaterinburg = "ekb"
    case nizhnyNovgorod = "nnv"
    case kazan = "kzn"
    case vyborg = "vbg"
    case samara = "smr"
    case krasnodar = "krd"
    case sochi = "sochi"
    case ufa = "ufa"
    case krasnoyarsk = "krasnoyarsk"
    case kyiv = "kev"
    case newYork = "new-york"

    var fullName: String {
            switch self {
            case .saintPetersburg:
                return "Saint Petersburg"
            case .moscow:
                return "Moscow"
            case .novosibirsk:
                return "Novosibirsk"
            case .yekaterinburg:
                return "Yekaterinburg"
            case .nizhnyNovgorod:
                return "Nizhny Novgorod"
            case .kazan:
                return "Kazan"
            case .vyborg:
                return "Vyborg"
            case .samara:
                return "Samara"
            case .krasnodar:
                return "Krasnodar"
            case .sochi:
                return "Sochi"
            case .ufa:
                return "Ufa"
            case .krasnoyarsk:
                return "Krasnoyarsk"
            case .kyiv:
                return "Kyiv"
            case .newYork:
                return "New York"
            }
        }
}
func chooseCity(for city: String) -> City {
    switch city {
    case "Saint Petersburg":
        return .saintPetersburg
    case "Moscow":
        return .moscow
    case "Novosibirsk":
        return .novosibirsk
    case "Yekaterinburg":
        return .yekaterinburg
    case "Nizhny Novgorod":
        return .nizhnyNovgorod
    case "Kazan":
        return .kazan
    case "Vyborg":
        return .vyborg
    case "Samara":
        return .samara
    case "Krasnodar":
        return .krasnodar
    case "Sochi":
        return .sochi
    case "Ufa":
        return .ufa
    case "Krasnoyarsk":
        return .krasnoyarsk
    case "Kyiv":
        return .kyiv
    case "New York":
        return .newYork
    default:
        return .newYork
    }
}


//
//let city = City.moscow
//print("City code: \(city.rawValue)") // Выводит "msk"
//print("City full name: \(city.fullName)") // Выводит "Moscow"
