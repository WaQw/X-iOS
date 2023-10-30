//
//  AuthViewModel.swift
//  X-iOS
//
//  Created by Anqi on 2023/10/28.
//

import SwiftUI

class AuthViewModel: ObservableObject {
    
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User?
    
    // Check whether the user logged in before (token exists)
    init() {
        let defaults = UserDefaults.standard
        let token = defaults.object(forKey: "jsonwebtoken")
        
        if token != nil {
            isAuthenticated = true
            if let userId = defaults.object(forKey: "userid") {
                fetchUser(userId: userId as! String)
            }
        } else {
            isAuthenticated = false
        }
    }
    
    // Init once and share in different views
    static let shared = AuthViewModel()
    
    func register(name: String, email: String, password: String, username: String) {
        AuthServices.register(name: name, email: email, password: password, username: username) { result in
            switch result {
            case .success(let data):
                guard let user = try? JSONDecoder().decode(APIResponse.self, from: data!) else {
                    return
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func login(email: String, password: String) {
        let defaults = UserDefaults.standard
        AuthServices.login(email: email, password: password) { result in
            switch result {
            case .success(let data):
                guard let user = try? JSONDecoder().decode(APIResponse.self, from: data!) else {
                    return
                }
                // store the user's token to remember the login status
                DispatchQueue.main.async {
                    defaults.set(user.token, forKey: "jsonwebtoken")
                    defaults.set(user.user.id, forKey: "userid")
                    self.isAuthenticated = true
                    self.currentUser = user.user
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchUser(userId: String) {
        AuthServices.fetchUser(id: userId) { result in
            switch result {
            case .success(let data):
                guard let user = try? JSONDecoder().decode(User.self, from: data!) else {
                    return
                }
                DispatchQueue.main.async {
                    UserDefaults.standard.setValue(user.id, forKey: "userid")
                    self.isAuthenticated = true
                    self.currentUser = user
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
