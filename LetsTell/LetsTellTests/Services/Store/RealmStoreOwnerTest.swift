//
//  RealmStoreOwner.swift
//  LetsTellTests
//
//  Created by Павел Чернышев on 22.03.2021.
//

import XCTest
@testable import LetsTell

class RealmStoreOwnerTest: XCTestCase {
    
    func testAddGetAndRemove() throws {
        let realmStoreOwner = RealmOwnerStorage()
        XCTAssertTrue(realmStoreOwner.updateOwner(
                        Owner(id: "1",
                              name: "pavel",
                              email: "p@p.ru",
                              avatar: nil,
                              sex: "male",
                              countryId: 2,
                              languageId: 3,
                              about: "my",
                              country: "rus",
                              isEmailVerified: false)))
        XCTAssertEqual(realmStoreOwner.getOwner(),
                       Owner(id: "1",
                             name: "pavel",
                             email: "p@p.ru",
                             avatar: nil,
                             sex: "male",
                             countryId: 2,
                             languageId: 3,
                             about: "my",
                             country: "rus",
                             isEmailVerified: false))
        XCTAssertTrue(realmStoreOwner.removeAll())
        XCTAssertNil(realmStoreOwner.getOwner())
    }
    
    func testAddGetFailureAndRemove() throws {
        let realmStoreOwner = RealmOwnerStorage()
        XCTAssertTrue(realmStoreOwner.updateOwner(
                        Owner(id: "1",
                              name: "pavel",
                              email: "p@p.ru",
                              avatar: nil,
                              sex: "male",
                              countryId: 2,
                              languageId: 3,
                              about: "my",
                              country: "rus",
                              isEmailVerified: false)))
        XCTAssertNotEqual(realmStoreOwner.getOwner(),
                          Owner(id: "12",
                                name: "pavel",
                                email: "p@p.ru",
                                avatar: nil,
                                sex: "male",
                                countryId: 2,
                                languageId: 3,
                                about: "my",
                                country: "rus",
                                isEmailVerified: false))
        XCTAssertTrue(realmStoreOwner.removeAll())
        XCTAssertNil(realmStoreOwner.getOwner())
    }
}
