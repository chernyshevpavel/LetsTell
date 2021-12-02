//
//  LibGenresTests.swift
//  LetsTellTests
//
//  Created by Павел Чернышев on 24.05.2021.
//

import XCTest
import Alamofire
@testable import LetsTell

class LibGenresTests: XCTestCase {

    func testGetList() throws {
        guard let baseUrl = URL(string: "https://lets-tell.herokuapp.com/api/v1") else {
            fatalError("Wrong server url")
        }
        
        let requestFactory = RequestFactory(baseUrl: baseUrl)
        let expect = expectation(description: "genres getted")
        let errorParser = ErrorParserState<ErrorList>()
        let lib = requestFactory.makeLibRequestFactory(errorParser: errorParser)
        lib.genres { response in
            switch response.result {
            case .success(let genresResult):
                guard let genre = genresResult.body.first else {
                    XCTFail("Genres not found")
                    return
                }
                XCTAssertEqual(genre.id, 1)
                XCTAssertEqual(genre.name, "Horror")
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
