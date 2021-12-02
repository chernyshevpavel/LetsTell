//
//  Token.swift
//  LetsTell
//
//  Created by Павел Чернышев on 21.03.2021.
//

import Foundation

struct Token {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
}

extension Token: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.accessToken == rhs.accessToken &&
            lhs.tokenType == rhs.tokenType &&
            lhs.expiresIn == rhs.expiresIn
    }
}
