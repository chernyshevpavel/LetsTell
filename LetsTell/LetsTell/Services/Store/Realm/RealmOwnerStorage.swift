//
//  RealmUserPreferences.swift
//  LetsTell
//
//  Created by Павел Чернышев on 17.03.2021.
//

import Foundation
import RealmSwift

class RealmOwnerStorage: OwnerStorage, RealmInitializer {
    
    func getOwner() -> Owner? {
        let realm = initRealm()
        guard let owner = realm.objects(OwnerRealm.self).first else {
            return nil
        }
        return convertToOwner(ownerRealm: owner)
    }
    
    func updateOwner(_ user: Owner) -> Bool {
        do {
            guard removeAll() else {
                return false
            }
            let realm = initRealm()
            try realm.write {
                realm.add(OwnerRealm(currentUser: user))
            }
        } catch let error {
            print(error)
            return false
        }
        return true
    }
    
    func removeAll() -> Bool {
        do {
            let realm = initRealm()
            try realm.write {
                let objects = realm.objects(OwnerRealm.self)
                realm.delete(objects)
            }
        } catch let error {
            print(error)
            return false
        }
        return true
    }
    
    public func convertToOwner(ownerRealm: OwnerRealm) -> Owner {
        Owner(
            id: ownerRealm.id,
            name: ownerRealm.name,
            email: ownerRealm.email,
            avatar: ownerRealm.avatar,
            sex: ownerRealm.sex,
            countryId: ownerRealm.countryId,
            languageId: ownerRealm.languageId,
            about: ownerRealm.about,
            country: ownerRealm.country,
            isEmailVerified: ownerRealm.isEmailVerified
        )
    }
    
    private func getEmptyCurrentUser() -> Owner {
        Owner(
            id: "",
            name: "",
            email: "",
            avatar: "",
            sex: "",
            countryId: 0,
            languageId: 0,
            about: "",
            country: "",
            isEmailVerified: false
        )
    }
}
