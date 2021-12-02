//
//  RealmInitializer.swift
//  LetsTell
//
//  Created by Павел Чернышев on 30.05.2021.
//

import Foundation
import RealmSwift

protocol RealmInitializer { }

extension RealmInitializer {
    func initRealm() -> Realm {
        do {
            return try Realm.init()
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
}
