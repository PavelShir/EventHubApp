//
//  PasswordResetManager.swift
//  EventHub
//
//  Created by Павел Широкий on 01.12.2024.
//

import FirebaseAuth

class PasswordResetManager {
    
    static let shared = PasswordResetManager()
    
    func sendPasswordReset(to email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
