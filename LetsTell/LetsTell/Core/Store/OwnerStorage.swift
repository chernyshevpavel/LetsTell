//
//  StoreCurrentUser.swift
//  LetsTell
//
//  Created by Павел Чернышев on 17.03.2021.
//

import Foundation

protocol OwnerStorage {
    func getOwner() -> Owner?
    func updateOwner(_ user: Owner) -> Bool
    func removeAll() -> Bool
}
