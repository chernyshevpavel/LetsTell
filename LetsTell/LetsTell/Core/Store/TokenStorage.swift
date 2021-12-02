//
//  StoreToken.swift
//  LetsTell
//
//  Created by Павел Чернышев on 21.03.2021.
//

import Foundation

protocol TokenStorage {
    func getToken() -> Token?
    func setToken(_ token: Token) -> Bool
    func removeToken() -> Bool
}
