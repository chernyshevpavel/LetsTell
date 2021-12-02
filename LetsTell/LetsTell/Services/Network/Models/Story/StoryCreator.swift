//
//  Master.swift
//  LetsTell
//
//  Created by Павел Чернышев on 01.04.2021.
//

import Foundation
struct StoryCreator: Codable, Hashable {
    let id: String
    let name: String
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case id, name, avatar
    }
}
