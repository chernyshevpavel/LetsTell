//
//  LoginResult.swift
//  LetsTell
//
//  Created by Павел Чернышев on 13.03.2021.
//

import Foundation

struct LoginResult: Codable {
    let status: String
    let body: LoginResultBody
}

struct LoginResultBody: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let user: Owner
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case user = "user"
    }
}
