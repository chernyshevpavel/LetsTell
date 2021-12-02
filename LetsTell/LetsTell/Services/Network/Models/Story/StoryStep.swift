//
//  StoryStep.swift
//  LetsTell
//
//  Created by Павел Чернышев on 01.04.2021.
//

import Foundation
struct StoryStep: Codable, Identifiable, Hashable  {
    let ownRate: Int?
    let rate: Int
    let rates: [Rate]
    let id: String
    let author: StoryCreator
    let text: String
    let length: Int
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case ownRate = "own_rate"
        case rate, rates, id, author, text, length
        case createdAt = "created_at"
    }
}
