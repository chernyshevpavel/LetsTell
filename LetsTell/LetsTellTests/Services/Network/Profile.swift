//
//  Profile.swift
//  LetsTellTests
//
//  Created by Павел Чернышев on 30.03.2021.
//

import XCTest
import Alamofire
@testable import LetsTell

class Profile: XCTestCase {

    func testGetCurrent() throws {
        guard let baseUrl = URL(string: "https://lets-tell.herokuapp.com/api/v1") else {
            fatalError("Wrong server url")
        }
        
        let requestFactory = RequestFactory(baseUrl: baseUrl)
        let expect = expectation(description: "profile getted")
        let errorParser = ErrorParserState<ErrorList>()
        let auth = requestFactory.makeAuthRequestFactory(errorParser: errorParser)
        auth.login(email: "vados.sparx@gmail.com", password: "123123") { response in
            switch response.result {
            case .success(let loginResult):
                let token = Token(
                accessToken: loginResult.body.accessToken,
                tokenType: loginResult.body.tokenType,
                expiresIn: loginResult.body.expiresIn)
               // requestFactory.commonSession.
                requestFactory.setToken(token: token)
                let profileFactory = requestFactory.makeProfileFactory(errorParser: errorParser)
                
                profileFactory.get { profileResponse in
                    switch profileResponse.result {
                    case .success(let model):
                        XCTAssertEqual(model.body.id, "d3e233d7-3786-4595-af87-9e211356bcf6")
                        XCTAssertEqual(model.body.email, "vados.sparx@gmail.com")
                        XCTAssertEqual(model.body.sex, "male")
                        XCTAssertEqual(model.body.languageId, 1)
                        XCTAssertEqual(model.body.countryId, 1)
                        XCTAssertTrue(model.body.isEmailVerified)
                        expect.fulfill()
                    case.failure(let error):
                        if let parsedError = errorParser.parsedError {
                            XCTFail("\(parsedError.errors.joined())")
                        }
                        XCTFail(error.localizedDescription)
                    }
                }
                
            case .failure(let error):
                if let parsedError = errorParser.parsedError {
                    XCTFail("\(parsedError.errors.joined())")
                }
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    func testFailureWithouToken() throws {
        guard let baseUrl = URL(string: "https://lets-tell.herokuapp.com/api/v1") else {
            fatalError("Wrong server url")
        }
        let requestFactory = RequestFactory(baseUrl: baseUrl)
        let expect = expectation(description: "logged in")
        let errorParser = ErrorParserState<ErrorList>()
        let auth = requestFactory.makeAuthRequestFactory(errorParser: errorParser)
        auth.login(email: "vados.sparx@gmail.com", password: "123123") { response in
            switch response.result {
            case .success:
                let profileFactory = requestFactory.makeProfileFactory(errorParser: errorParser)
                profileFactory.get { profileResponse in
                    switch profileResponse.result {
                    case .success:
                        XCTFail("Profile must be null without token")
                        
                    case.failure(let error):
                        guard let parsedError = errorParser.parsedError else {
                            XCTFail("Cannot parse error to error list: \(error.localizedDescription)")
                            return
                        }
                        XCTAssertEqual(parsedError.status, "error")
                        XCTAssertEqual(parsedError.errors[0], "Authentication error.")
                        expect.fulfill()
                    }
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}
