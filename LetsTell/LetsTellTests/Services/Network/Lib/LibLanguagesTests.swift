//
//  LibLanguagesTests.swift
//  LetsTellTests
//
//  Created by Павел Чернышев on 24.05.2021.
//

import XCTest
import Alamofire
@testable import LetsTell

class LibLanguagesTests: XCTestCase {

    func testGetList() throws {
        guard let baseUrl = URL(string: "https://lets-tell.herokuapp.com/api/v1") else {
            fatalError("Wrong server url")
        }
        
        let requestFactory = RequestFactory(baseUrl: baseUrl)
        let expect = expectation(description: "languages getted")
        let errorParser = ErrorParserState<ErrorList>()
        let lib = requestFactory.makeLibRequestFactory(errorParser: errorParser)
        lib.languages { response in
            switch response.result {
            case .success(let languagesResult):
                guard let lang = languagesResult.body.first else {
                    XCTFail("languages not found")
                    return
                }
                XCTAssertEqual(lang.id, 1)
                XCTAssertEqual(lang.name, "Русский")
                XCTAssertEqual(lang.defaultName, "Русский")
                
                expect.fulfill()
            case .failure(let error):
                if let parsedError = errorParser.parsedError {
                    XCTFail("\(parsedError.errors.joined())")
                }
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 5)
    }
}
