//
//  TokenRealm.swift
//  LetsTell
//
//  Created by Павел Чернышев on 21.03.2021.
//

import Foundation
import RealmSwift

class TokenRealm: Object {
    @objc dynamic var accessToken: String = ""
    @objc dynamic var tokenType: String = ""
    @objc dynamic var expiresIn: Int = 0
    
    override init() {
    }
    
    init(token: Token) {
        self.accessToken = token.accessToken
        self.tokenType = token.tokenType
        self.expiresIn = token.expiresIn
    }
}
