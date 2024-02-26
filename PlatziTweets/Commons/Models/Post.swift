//
//  Post.swift
//  PlatziTweets
//
//  Created by Jozek Hajduk on 23/02/24.
//

import Foundation

struct Post: Codable {
    let id: String
    let author: User
    let imageUrl: String
    let text: String
    let videoUrl: String
    let location: PostLocation
    let hasVideo: Bool
    let hasImage: Bool
    let hasLocation: Bool
    let createdAt: String
}
