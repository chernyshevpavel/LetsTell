//
//  Language.swift
//  LetsTell
//
//  Created by Павел Чернышев on 01.04.2021.
//

import Foundation
struct Language: Codable, Hashable {
    let id: Int
    let name: String
    let defaultName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case defaultName = "default_name"
    }
}
