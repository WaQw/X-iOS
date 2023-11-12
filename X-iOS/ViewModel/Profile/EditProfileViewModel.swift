//
//  EditProfileViewModel.swift
//  X-iOS
//
//  Created by Anqi on 2023/11/11.
//

import SwiftUI

class EditProfileViewModel: ObservableObject {
    
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func save(name: String?, bio: String?, website: String?, location: String?) {
        guard let newName = name else { return }
        guard let newBio = bio else { return }
        guard let newWebsite = website else { return }
        guard let newLocation = location else { return }
        
        self.user.name = newName
        self.user.bio = newBio
        self.user.website = newWebsite
        self.user.location = newLocation
    }
}
