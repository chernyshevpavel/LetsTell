//
//  Authorization.swift
//  LetsTellTests
//
//  Created by Павел Чернышев on 15.03.2021.
//

import XCTest
import Alamofire
@testable import LetsTell

class Authorization: XCTestCase {

    func testLogin() throws {
        guard let baseUrl = URL(string: "https://lets-tell.herokuapp.com/api/v1") else {
            fatalError("Wrong server url")
        }
        
        let requestFactory = RequestFactory(baseUrl: baseUrl)
        let expect = expectation(description: "logged in")
        let errorParser = ErrorParserState<ErrorList>()
        let auth = requestFactory.makeAuthRequestFactory(errorParser: errorParser)
        auth.login(email: "vados.sparx@gmail.com", password: "123123") { response in
            switch response.result {
            case .success(let loginResult):
                XCTAssertEqual(loginResult.status, "ok")
                XCTAssertEqual(loginResult.body.tokenType, "bearer")
                XCTAssertEqual(loginResult.body.user.id, "d3e233d7-3786-4595-af87-9e211356bcf6")
                XCTAssertEqual(loginResult.body.user.email, "vados.sparx@gmail.com")
                XCTAssertGreaterThan(loginResult.body.expiresIn, 1)
                XCTAssertFalse(loginResult.body.accessToken.isEmpty)
                
                expect.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    func testAuthHelper() throws {
        let authHelper = AuthHelper()
        
        let expect = expectation(description: "Auth helper")
        authHelper.auth { (token, owner) in
            XCTAssertEqual(token.tokenType, "bearer")
            XCTAssertEqual(owner.id, "d3e233d7-3786-4595-af87-9e211356bcf6")
            XCTAssertEqual(owner.email, "vados.sparx@gmail.com")
            XCTAssertGreaterThan(token.expiresIn, 1)
            XCTAssertFalse(token.accessToken.isEmpty)
            expect.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    
    func testWrongPass() throws {
        guard let baseUrl = URL(string: "https://lets-tell.herokuapp.com/api/v1") else {
            fatalError("Wrong server url")
        }
        let requestFactory = RequestFactory(baseUrl: baseUrl)
        let expect = expectation(description: "logged in")
        let errorParser = ErrorParserState<ErrorList>()
        let auth = requestFactory.makeAuthRequestFactory(errorParser: errorParser)
        auth.login(email: "vados.sparx@gmail.com", password: "123123***") { response in
            switch response.result {
            case .success:
                XCTFail("Password must be incorrect")
            case .failure:
                guard let parsedError = errorParser.parsedError else {
                    XCTFail("Cannot parse error to error list")
                    return
                }
                XCTAssertEqual(parsedError.status, "error")
                XCTAssertEqual(parsedError.errors[0], "You entered an incorrect email, password, or both")
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    func testEmptyPass() throws {
        guard let baseUrl = URL(string: "https://lets-tell.herokuapp.com/api/v1") else {
            fatalError("Wrong server url")
        }
        let requestFactory = RequestFactory(baseUrl: baseUrl)
        let expect = expectation(description: "logged in")
        let errorParser = ErrorParserState<ErrorList>()
        let auth = requestFactory.makeAuthRequestFactory(errorParser: errorParser)
        auth.login(email: "vados.sparx@gmail.com", password: "") { response in
            switch response.result {
            case .success:
                XCTFail("Password must be incorrect")
            case .failure:
                guard let parsedError = errorParser.parsedError else {
                    XCTFail("Cannot parse error to error list")
                    return
                }
                XCTAssertEqual(parsedError.status, "error")
                XCTAssertEqual(parsedError.errors[0], "The password field is required.")
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    func testEmptyEmail() throws {
        guard let baseUrl = URL(string: "https://lets-tell.herokuapp.com/api/v1") else {
            fatalError("Wrong server url")
        }
        let requestFactory = RequestFactory(baseUrl: baseUrl)
        let expect = expectation(description: "logged in")
        let errorParser = ErrorParserState<ErrorList>()
        let auth = requestFactory.makeAuthRequestFactory(errorParser: errorParser)
        auth.login(email: "", password: "123") { response in
            switch response.result {
            case .success:
                XCTFail("Password must be incorrect")
            case .failure(let error):
                guard let parsedError = errorParser.parsedError else {
                    XCTFail("Cannot parse error to error list \(error.localizedDescription)")
                    return
                }
                XCTAssertEqual(parsedError.status, "error")
                XCTAssertEqual(parsedError.errors[0], "The email field is required.")
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    func testNotValidEmail() throws {
        guard let baseUrl = URL(string: "https://lets-tell.herokuapp.com/api/v1") else {
            fatalError("Wrong server url")
        }
        let requestFactory = RequestFactory(baseUrl: baseUrl)
        let expect = expectation(description: "logged in")
        let errorParser = ErrorParserState<ErrorList>()
        let auth = requestFactory.makeAuthRequestFactory(errorParser: errorParser)
        auth.login(email: "NotEmail", password: "123") { response in
            switch response.result {
            case .success:
                XCTFail("Password must be incorrect")
            case .failure:
                guard let parsedError = errorParser.parsedError else {
                    XCTFail("Cannot parse error to error list")
                    return
                }
                XCTAssertEqual(parsedError.status, "error")
                XCTAssertEqual(parsedError.errors[0], "The email must be a valid email address.")
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testFailureLogin() throws {
        guard let baseUrl = URL(string: "failure.url.com") else {
            fatalError("something wrong")
        }
        let requestFactory = RequestFactory(baseUrl: baseUrl)
        let expect = expectation(description: "logged in")
        let errorParser = ErrorParserState<ErrorList>()
        let auth = requestFactory.makeAuthRequestFactory(errorParser: errorParser)
        auth.login(email: "Somebody", password: "mypassword") { response in
            switch response.result {
            case .success(let login):
                XCTFail("Must have failed \(login)")
            case .failure:
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testRefreshToken() throws {
        guard let baseUrl = URL(string: "https://lets-tell.herokuapp.com/api/v1") else {
            fatalError("Wrong server url")
        }
        
        let requestFactory = RequestFactory(baseUrl: baseUrl)
        let expect = expectation(description: "logged in")
        let errorParser = ErrorParserState<ErrorList>()
        var auth = requestFactory.makeAuthRequestFactory(errorParser: errorParser)
        auth.login(email: "vados.sparx@gmail.com", password: "123123") { response in
            switch response.result {
            case .success(let loginResult):
                let token = Token(accessToken: loginResult.body.accessToken, tokenType: loginResult.body.tokenType, expiresIn: loginResult.body.expiresIn)
                requestFactory.setToken(token: token)
                auth = requestFactory.makeAuthRequestFactory(errorParser: errorParser)
                auth.refreshToken { refreshResponse in
                    switch refreshResponse.result {
                    case .success(let refreshResult):
                        XCTAssertNotEqual(refreshResult.body.accessToken, token.accessToken)
                        XCTAssertEqual(refreshResult.body.expiresIn, token.expiresIn)
                        XCTAssertEqual(refreshResult.body.tokenType, token.tokenType)
                        XCTAssertEqual(loginResult.status, "ok")
                        XCTAssertEqual(loginResult.body.tokenType, "bearer")
                        XCTAssertEqual(loginResult.body.user.id, "d3e233d7-3786-4595-af87-9e211356bcf6")
                        XCTAssertEqual(loginResult.body.user.email, "vados.sparx@gmail.com")
                        XCTAssertGreaterThan(loginResult.body.expiresIn, 1)
                        XCTAssertFalse(loginResult.body.accessToken.isEmpty)
                        
                        expect.fulfill()
                    case .failure(let error):
                        if let parsedError = errorParser.parsedError {
                            XCTFail("\(parsedError.errors.joined())")
                        }
                        XCTFail(error.localizedDescription)
                    }
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
}
