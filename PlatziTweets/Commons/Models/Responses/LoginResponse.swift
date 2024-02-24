//
//  LoginResponse.swift
//  PlatziTweets
//
//  Created by Jozek Hajduk on 23/02/24.
//

import Foundation

struct LoginResponse: Codable {
    let user: User
    let token: String
}
