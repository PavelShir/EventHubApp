//
//  GoogleAuthManager.swift
//  EventHub
//
//  Created by Павел Широкий on 30.11.2024.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

class GoogleAuthManager {
    
    static let shared = GoogleAuthManager()
    
    func createGoogleButton(target: Any?, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Login with Google", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button.setLeftButtontIcon(UIImage(named: "google logo")!, padding: -8)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.Authorization.cornerRadiusSignButton

        button.layer.shadowColor = UIColor(red: 0.826, green: 0.832, blue: 0.888, alpha: 0.25).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 15, height: 0)
        button.layer.shadowRadius = 30
        
        button.addTarget(target, action: action, for: .touchUpInside)
        
        return button
    }
    
    func signInWithGoogle(presentingViewController: UIViewController, completion: @escaping (Result<User, Error>) -> Void) async {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("Error: Firebase clientID not found.")
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = await windowScene.windows.first,
              let rootViewController = await window.rootViewController else {
              print("There is no root view controller!")
              return
            }
        
        do {
            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            
            let user = userAuthentication.user
            guard let idToken = user.idToken else { return print( "ID token missing") }
            let accessToken = user.accessToken
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                           accessToken: accessToken.tokenString)
            
            let result = try await Auth.auth().signIn(with: credential)
            let firebaseUser = result.user
            print("User \(firebaseUser.uid) signed in with email \(firebaseUser.email ?? "unknown")")
            return
        }
        catch {
            print("error")
            return
        }
    }
    
}


