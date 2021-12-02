//
//  Rate.swift
//  LetsTell
//
//  Created by Павел Чернышев on 01.04.2021.
//

import Foundation

struct Rate: Codable, Hashable {

    let rate: Int
    let user: StoryCreator?
    
    static func == (lhs: Rate, rhs: Rate) -> Bool {
        lhs.rate == rhs.rate && lhs.user == rhs.user
    }
}
