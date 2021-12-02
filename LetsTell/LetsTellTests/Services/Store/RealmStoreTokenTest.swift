//
//  RealmStoreToken.swift
//  LetsTellTests
//
//  Created by Павел Чернышев on 22.03.2021.
//

import XCTest
import Alamofire
@testable import LetsTell

class RealmStoreTokenTest: XCTestCase {
    
    func testAddGetAndRemove() throws {
        let realmStoreToken = RealmTokenStorage()
        XCTAssertTrue(realmStoreToken.setToken(Token(accessToken: "tokenhash", tokenType: "barrer", expiresIn: 1)))
        XCTAssertEqual(realmStoreToken.getToken(), Token(accessToken: "tokenhash", tokenType: "barrer", expiresIn: 1))
        XCTAssertTrue(realmStoreToken.removeToken())
        XCTAssertNil(realmStoreToken.getToken())
    }
    
    func testAddGetFailureAndRemove() throws {
        let realmStoreToken = RealmTokenStorage()
        XCTAssertTrue(realmStoreToken.setToken(Token(accessToken: "tokenhash", tokenType: "barrer", expiresIn: 1)))
        XCTAssertNotEqual(realmStoreToken.getToken(), Token(accessToken: "tokenhash1", tokenType: "barrer", expiresIn: 1))
        XCTAssertTrue(realmStoreToken.removeToken())
        XCTAssertNil(realmStoreToken.getToken())
    }
}
