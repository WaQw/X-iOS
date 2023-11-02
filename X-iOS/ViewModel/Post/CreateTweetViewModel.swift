//
//  CreateTweetViewModel.swift
//  X-iOS
//
//  Created by Anqi on 2023/10/30.
//

import SwiftUI

class CreateTweetViewModel: ObservableObject {
    func uploadPost(text: String, image: UIImage?) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        RequestServices.requestDomain = "http://localhost:3000/tweets"
        RequestServices.postTweet(text: text, user: user.name, username: user.username, userId: user.id) { result in
            if let image = image {
                if let id = result?["_id"] {
                    print(id)
                    ImageUploader.uploadImage(paramName: "upload", fileName: "myImage", urlPath: "/tweets/\(id)/image", image: image)
                    print("/tweets/\(id)/image")
                }
            }
        }
    }
}
