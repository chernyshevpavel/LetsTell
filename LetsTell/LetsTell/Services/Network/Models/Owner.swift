//
//  User.swift
//  LetsTell
//
//  Created by Павел Чернышев on 19.03.2021.
//

import Foundation

struct Owner: Codable {
    var id: String
    var name: String
    var email: String
    var avatar: String?
    var sex: String
    var countryId: Int
    var languageId: Int
    var about: String?
    var country: String?
    var isEmailVerified: Bool
        
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case email = "email"
        case avatar = "avatar"
        case sex = "sex"
        case countryId = "country_id"
        case languageId = "language_id"
        case about = "about"
        case country = "country"
        case isEmailVerified = "is_email_verified"
    }
}

extension Owner: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.email == rhs.email &&
            lhs.avatar == rhs.avatar &&
            lhs.sex == rhs.sex &&
            lhs.countryId == rhs.countryId &&
            lhs.languageId == rhs.languageId &&
            lhs.about == rhs.about &&
            lhs.country == rhs.country &&
            lhs.isEmailVerified == rhs.isEmailVerified
    }
}
