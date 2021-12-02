//
//  Feed.swift
//  LetsTellTests
//
//  Created by Павел Чернышев on 02.04.2021.
//

import XCTest
import Alamofire
@testable import LetsTell

class StoryTest: XCTestCase {
    
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

    func testStoryStepGet() throws {
        let requestFactory = getRequestFactory()
        let storyFactory = requestFactory.makeStoryRequestFactory(errorParser: errorParser)
        let expect = expectation(description: "Story steps")
        storyFactory.getSteps(story: "7ba04a2f-dc3b-4901-9b71-2249ac0e98c7") { (afResponse) in
            switch afResponse.result {
            case .success(let baseBodyRes):
                XCTAssertEqual(baseBodyRes.body.count, 18)
                expect.fulfill()
            case .failure(let error):
                if let parsedError = error.underlyingError as? ErrorList {
                    XCTFail(parsedError.errors.joined())
                } else {
                    XCTFail(error.localizedDescription)
                }
            }
        }
        
        waitForExpectations(timeout: 5)
    }
    
    func testStoryStepGetFailure() throws {
        let requestFactory = getRequestFactory()
        let storyFactory = requestFactory.makeStoryRequestFactory(errorParser: errorParser)
        let expect = expectation(description: "story steps not exist")
        storyFactory.getSteps(story: "-") { (afResponse) in
            switch afResponse.result {
            case .success:
                XCTFail("Must be an error")
            case .failure(let error):
                if let parsedError = error.underlyingError as? ErrorList {
                    XCTAssertEqual(parsedError.errors.joined(), "The resource was not found.")
                    expect.fulfill()
                } else {
                    XCTFail(error.localizedDescription)
                }
            }
        }
        
        waitForExpectations(timeout: 5)
    }

}
