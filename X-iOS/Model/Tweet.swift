//
//  Tweet.swift
//  X-iOS
//
//  Created by Anqi on 2023/10/30.
//

import SwiftUI

struct Tweet: Identifiable, Decodable {
    let _id: String
    var id: String {
        return _id
    }
    var text: String
    var userId: String
    var username: String
    var user: String
}
