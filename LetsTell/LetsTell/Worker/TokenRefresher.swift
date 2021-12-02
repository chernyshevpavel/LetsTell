//
//  TokenRefresher.swift
//  LetsTell
//
//  Created by Павел Чернышев on 30.03.2021.
//

import Foundation
import FirebaseCrashlytics

class TokenRefresher: TokenRefresherProtocol {
    private let store: TokenStorage
    private let requestFactory: RequestFactory
    private lazy var token = store.getToken()
    private let errorLogger: ErrorLogger
    private let userStorage: OwnerStorage
    
    init(store: TokenStorage, requestFactory: RequestFactory, errorLogger: ErrorLogger, userStorage: OwnerStorage) {
        self.store = store
        self.requestFactory = requestFactory
        self.errorLogger = errorLogger
        self.userStorage = userStorage
    }
    
    public func refresh(completion: @escaping (Bool) -> Void) {
        guard let token = token else {
            completion(false)
            return
        }
        requestFactory.setToken(token: token)
        let authFactory = requestFactory.makeAuthRequestFactory(errorParser: ErrorParser())
        authFactory.refreshToken { response in
            switch response.result {
            case .success(let model):
                let newToken = Token(
                    accessToken: model.body.accessToken,
                    tokenType: model.body.tokenType,
                    expiresIn: model.body.expiresIn + Int(NSDate().timeIntervalSince1970))
                if !self.store.setToken(newToken) {
                    self.errorLogger.log(NSError.init(
                                            domain: "TokenRefresher.errorRefresh",
                                            code: 1001,
                                            userInfo: ["error description": "Couldn't update token"]))
                    completion(false)
                } else {
                    if !self.userStorage.updateOwner(model.body.user) {
                        print("Couldn't update owner info ")
                    }
                    completion(true)
                }
            case .failure(let error):
                completion(false)
                print(error)
            }
        }
    }
    
}
