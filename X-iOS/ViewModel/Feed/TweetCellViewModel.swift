//
//  TweetCellViewModel.swift
//  X-iOS
//
//  Created by Anqi on 2023/11/3.
//

import Foundation

class TweetCellViewModel: ObservableObject {
    
    @Published var tweet: Tweet
    
    // Come from the superview, feed passes the tweet to here
    init(tweet: Tweet) {
        self.tweet = tweet
    }
    
    
}
