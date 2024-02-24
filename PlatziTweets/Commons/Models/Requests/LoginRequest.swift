//
//  LoginRequest.swift
//  PlatziTweets
//
//  Created by Jozek Hajduk on 23/02/24.
//

import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
}
