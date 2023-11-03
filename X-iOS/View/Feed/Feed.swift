//
//  Feed.swift
//  X-iOS
//
//  Created by Anqi on 2023/10/15.
//

import SwiftUI

struct Feed: View {
    
    let user: User
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            LazyVStack(spacing: 18) {
                ForEach(viewModel.tweets) { tweet in
                    TweetCellView(tweet: tweet.text)
                    Divider()
                }
            }
            .padding(.top)
            .padding(.horizontal)
            .zIndex(0)
        })
    }
}
