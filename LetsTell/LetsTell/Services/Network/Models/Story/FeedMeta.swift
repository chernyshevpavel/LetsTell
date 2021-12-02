//
//  FeedMeta.swift
//  LetsTell
//
//  Created by Павел Чернышев on 02.04.2021.
//

import Foundation

struct FeedMeta: Codable {
    let currentPage: Int
    let from: Int?
    let lastPage: Int
    let path: String
    let perPage: Int
    let to: Int?
    let total: Int
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case from
        case lastPage = "last_page"
        case path
        case perPage = "per_page"
        case to, total
    }
}
