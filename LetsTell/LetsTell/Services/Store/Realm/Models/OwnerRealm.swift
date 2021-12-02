//
//  CurrentUserRealm.swift
//  LetsTell
//
//  Created by Павел Чернышев on 21.03.2021.
//

import Foundation
import RealmSwift

class OwnerRealm: Object {
    @objc dynamic var id: String
    @objc dynamic var name: String
    @objc dynamic var email: String
    @objc dynamic var avatar: String?
    @objc dynamic var sex: String
    @objc dynamic var countryId: Int
    @objc dynamic var languageId: Int
    @objc dynamic var about: String?
    @objc dynamic var country: String?
    @objc dynamic var isEmailVerified: Bool
    
    override init() {
        id = ""
        name = ""
        email = ""
        sex = ""
        countryId = 0
        languageId = 0
        isEmailVerified = false
    }
    
    init(currentUser: Owner) {
        self.id = currentUser.id
        self.name = currentUser.name
        self.email = currentUser.email
        self.avatar = currentUser.avatar
        self.sex = currentUser.sex
        self.countryId = currentUser.countryId
        self.languageId = currentUser.languageId
        self.about = currentUser.about
        self.country = currentUser.country
        self.isEmailVerified = currentUser.isEmailVerified
        
    }
    
    override static func primaryKey() -> String? {
        "id"
    }
}
