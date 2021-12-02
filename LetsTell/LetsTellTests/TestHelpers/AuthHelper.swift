//
//  AuthHelper.swift
//  LetsTellTests
//
//  Created by Павел Чернышев on 30.03.2021.
//

import XCTest
import Alamofire
@testable import LetsTell

class AuthHelper {
    
    let requestFactory: RequestFactory
    
    init() {
        guard let baseUrl = URL(string: "https://lets-tell.herokuapp.com/api/v1") else {
            fatalError("Wrong server url")
        }
        requestFactory = RequestFactory(baseUrl: baseUrl)
    }
    
    // MARK: - ENTER YOU CREDENTIONALS
    func auth(completion: @escaping (Token, Owner) -> Void) {
        let errorParser = ErrorParserState<ErrorList>()
        let auth = requestFactory.makeAuthRequestFactory(errorParser: errorParser)
        auth.login(email: "****@gmail.com", password: "********") { response in
            switch response.result {
            case .success(let loginResult):
                let token = Token(
                    accessToken: loginResult.body.accessToken,
                    tokenType: loginResult.body.tokenType,
                    expiresIn: loginResult.body.expiresIn)
                let owner = loginResult.body.user
                self.requestFactory.setToken(token: token)
                completion(token, owner)
            case .failure(let error):
                guard let parsedError = errorParser.parsedError else {
                    fatalError(error.localizedDescription)
                }
                fatalError(parsedError.errors.first ?? "fatal auth")
            }
        }
    }
    
    func getRequestFactory() -> RequestFactory {
        self.requestFactory
    }
}
