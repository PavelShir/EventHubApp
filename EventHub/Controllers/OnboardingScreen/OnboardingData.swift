//
//  OnboardingData.swift
//  EventHub
//
//  Created by Anna Melekhina on 19.11.2024.
//

import UIKit

struct CarouselItems {
    
    static let imageNames: [String] = ["onboarding1", "onboarding2", "onboarding3"]
    
    
    static func makeItems() -> [Item] {
        return imageNames.map { Item(image: UIImage(named: $0)) }
    }
}


struct Item: Hashable {
    let image: UIImage?
}
