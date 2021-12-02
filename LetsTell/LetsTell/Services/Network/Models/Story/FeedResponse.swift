//
//  FeedRosponse.swift
//  LetsTell
//
//  Created by Павел Чернышев on 02.04.2021.
//

import Foundation

struct FeedResponse: Codable {
    let body: [Story]
    let links: Links
    let meta: FeedMeta
    let status: String
}
