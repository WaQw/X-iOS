//
//  FeedViewModel.swift
//  X-iOS
//
//  Created by Anqi on 2023/11/2.
//

import Foundation

class FeedViewModel: ObservableObject {
    
    @Published var tweets = [Tweet]()
    
    init() {
        fetchTweets()
    }
    
    func fetchTweets() {
        RequestServices.requestDomain = "http://localhost:3000/tweets"
        RequestServices.fetchTweets() { res in
            switch res{
                case .success(let data):
                    guard let tweets = try? JSONDecoder().decode([Tweet].self, from: data!) else { return }
                    DispatchQueue.main.async {
                        self.tweets = tweets
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
