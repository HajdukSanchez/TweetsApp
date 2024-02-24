//
//  PostRequest.swift
//  PlatziTweets
//
//  Created by Jozek Hajduk on 23/02/24.
//

import Foundation

struct PostRequest: Codable {
    let text: String
    let imageUrl: String
    let videoUrl: String
    let location: PostRequestLocation?
}
