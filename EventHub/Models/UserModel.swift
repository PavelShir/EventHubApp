//
//  User.swift
//  EventHub
//
//  Created by Павел Широкий on 20.11.2024.
//

import UIKit

struct UserModel: Codable, Equatable {
    
    var name: String
    let email: String
    let password: String
    var photoName: String
    
}
