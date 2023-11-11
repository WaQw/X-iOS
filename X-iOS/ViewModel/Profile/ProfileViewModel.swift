//
//  ProfileViewModel.swift
//  X-iOS
//
//  Created by Anqi on 2023/11/11.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
}
