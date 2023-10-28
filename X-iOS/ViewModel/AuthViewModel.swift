//
//  AuthViewModel.swift
//  X-iOS
//
//  Created by Anqi on 2023/10/28.
//

import SwiftUI

class AuthViewModel: ObservableObject {
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
}
