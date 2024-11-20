//
//  FirestoreManager.swift
//  EventHub
//
//  Created by Павел Широкий on 21.11.2024.
//

import FirebaseCore
import FirebaseFirestore

final class FirestoreManager {

    static let shared = FirestoreManager()
    private let db = Firestore.firestore()

    private init() {}

    func saveUserData(
        userID: String,
        username: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        let userRef = db.collection("users").document(userID)
        userRef.setData(["username": username]) { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success(()))
        }
    }

    func getUserData(
        userID: String,
        completion: @escaping (Result<[String: Any], Error>) -> Void
    ) {
        let userRef = db.collection("users").document(userID)
        userRef.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard  let document else  {
                completion(.failure(
                    NSError(
                        domain: "",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "No data found"]
                    )
                ))
                return
            }

            completion(.success(document.data() ?? [:]))
        }
    }
}

