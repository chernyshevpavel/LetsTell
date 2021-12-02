//
//  Feed.swift
//  LetsTellTests
//
//  Created by Павел Чернышев on 02.04.2021.
//

import XCTest
import Alamofire
@testable import LetsTell

class Feed: XCTestCase {
    
    var requestFactory: RequestFactory?
    var errorParser = ErrorParserState<ErrorList>()

    override func setUpWithError() throws {
        let authHelper = AuthHelper()
        let semaphore = DispatchSemaphore(value: 0)
        authHelper.auth { _, _ in
            self.requestFactory = authHelper.getRequestFactory()
            semaphore.signal()
        }
        semaphore.wait()
        try super.setUpWithError()
    }
    
    private func getRequestFactory() -> RequestFactory {
        guard let requestFactory = requestFactory else {
            XCTFail("reques factory is not exist")
            fatalError("reques factory is not exist")
        }
        return requestFactory
    }

    override func tearDownWithError() throws {
        requestFactory = nil
        try super.tearDownWithError()
    }

    func testFeedGet() throws {
        let requestFactory = getRequestFactory()
        let feedFactory = requestFactory.makeFeedFactory(errorParser: errorParser)
        
        let expect = expectation(description: "feed")
        feedFactory.get(page: 1, filters: nil) { response in
            switch response.result {
            case .success(let feed):
                XCTAssertEqual(feed.status, "ok")
                XCTAssertEqual(feed.body.count, feed.meta.perPage)
                expect.fulfill()
            case .failure(let error):
                if let parsedError = self.errorParser.parsedError {
                    XCTFail(parsedError.errors.isEmpty ? parsedError.errors[0] : "")
                }
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10)
    }
    
    func testFeedGetTestPagination() throws {
        let requestFactory = getRequestFactory()
        let feedFactory = requestFactory.makeFeedFactory(errorParser: errorParser)
        
        let expect = expectation(description: "feed pagination")
        feedFactory.get(page: 1, filters: nil) { response in
            switch response.result {
            case .success(let firstFeed):
                XCTAssertEqual(firstFeed.status, "ok")
                XCTAssertEqual(firstFeed.body.count, firstFeed.meta.perPage)
                XCTAssertGreaterThan(firstFeed.body.count, 1)
                feedFactory.get(page: 2, filters: nil) { secondResponse in
                    switch secondResponse.result {
                    case .success(let secondFeed):
                        XCTAssertEqual(secondFeed.status, "ok")
                        XCTAssertEqual(secondFeed.body.count, secondFeed.meta.perPage)
                        XCTAssertGreaterThan(secondFeed.body.count, 1)
                        XCTAssertNotEqual(firstFeed.body.first?.id, secondFeed.body.first?.id)
                        expect.fulfill()
                    case .failure(let error):
                        if let parsedError = self.errorParser.parsedError {
                            XCTFail(parsedError.errors.isEmpty ? parsedError.errors[0] : "")
                        }
                        XCTFail(error.localizedDescription)
                    }
                }
                
            case .failure(let error):
                if let parsedError = self.errorParser.parsedError {
                    XCTFail(parsedError.errors.isEmpty ? parsedError.errors[0] : "")
                }
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10)
    }
    
    func testFeedWithoutToken() throws {
        let requestFactory = getRequestFactory()
        requestFactory.setToken(token: Token(accessToken: "", tokenType: "", expiresIn: 0))
        let feedFactory = requestFactory.makeFeedFactory(errorParser: errorParser)
        
        let expect = expectation(description: "feed")
        feedFactory.get(page: 1, filters: nil) { response in
            switch response.result {
            case .success:
                XCTFail("Expect an error")
            case .failure:
                expect.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5)
    }
}
