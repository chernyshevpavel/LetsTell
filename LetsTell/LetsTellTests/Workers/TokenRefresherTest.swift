//
//  TokenRefresherTest.swift
//  LetsTellTests
//
//  Created by Павел Чернышев on 30.03.2021.
//

import XCTest
import Alamofire
@testable import LetsTell

class TokenRefresherTest: XCTestCase {

    func testRefreshToken() {
        let authHelper = AuthHelper()
        let expect = expectation(description: "Token refreshed")
        authHelper.auth { (token, _) in
            let storeToken = RealmTokenStorage()
            XCTAssertTrue(storeToken.setToken(token))
            let tokenRefresher = TokenRefresher(store: storeToken, requestFactory: authHelper.getRequestFactory(), errorLogger: PrintLogger(), userStorage: RealmOwnerStorage())
            tokenRefresher.refresh { succes in
                XCTAssertTrue(succes)
                guard let updatedToken = storeToken.getToken() else {
                    XCTFail("Token didn't save")
                    return
                }
                XCTAssertNotEqual(token, updatedToken)
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }
}
