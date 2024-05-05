//
//  Joke.swift
//  Sesi6FirstAPI
//
//  Created by Macbook Pro on 19/04/24.
//

import Foundation

struct Joke: Codable, Identifiable {
    var id: Int
    var type: String
    var setup: String
    var punchline: String
}
