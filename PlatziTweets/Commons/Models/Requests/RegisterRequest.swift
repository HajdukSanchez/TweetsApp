//
//  RegisterRequest.swift
//  PlatziTweets
//
//  Created by Jozek Hajduk on 23/02/24.
//

import Foundation

struct RegisterRequest: Codable {
    let email: String
    let password: String
    let name: String
}
