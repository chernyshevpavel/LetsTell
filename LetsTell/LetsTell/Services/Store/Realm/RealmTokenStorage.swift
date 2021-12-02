//
//  RealmToken.swift
//  LetsTell
//
//  Created by Павел Чернышев on 21.03.2021.
//

import Foundation
import RealmSwift

class RealmTokenStorage: TokenStorage, RealmInitializer {
    
    func getToken() -> Token? {
        guard let token = initRealm().objects(TokenRealm.self).first else {
            return nil
        }
        return convertToToken(token)
    }
    
    func setToken(_ token: Token) -> Bool {
        var res = false
        let tokenRealm = TokenRealm(token: token)
        if removeToken() {
            do {
                let realm = initRealm()
                try realm.write {
                    realm.add(tokenRealm)
                    res = true
                }
            } catch let error {
                print(error.localizedDescription)
                return false
            }
        }
        return res
    }
    
    func removeToken() -> Bool {
        do {
            let realm = initRealm()
            try realm.write {
                let objects = realm.objects(TokenRealm.self)
                realm.delete(objects)
            }
        } catch let error {
            print(error.localizedDescription)
            return false
        }
        return true
    }
    
    private func convertToToken(_ tokenRealm: TokenRealm) -> Token {
        Token(
            accessToken: tokenRealm.accessToken,
            tokenType: tokenRealm.tokenType,
            expiresIn: tokenRealm.expiresIn
        )
    }
    
    private func getEmptyToken() -> Token {
        Token(
            accessToken: "",
            tokenType: "",
            expiresIn: 0
        )
    }
}
