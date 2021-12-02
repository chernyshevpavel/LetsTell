//
//  TockenChecker.swift
//  LetsTell
//
//  Created by Павел Чернышев on 29.03.2021.
//

import Foundation

class TockenChecker: TockenCheckerProtocol {
    private let store: TokenStorage
    private lazy var token = store.getToken()
    
    init(store: TokenStorage) {
        self.store = store
    }
    
    public func isExist() -> Bool {
        token != nil
    }
    
    public func isAlive() -> Bool {
        guard let token = token else {
            return false
        }
        return token.expiresIn > Int(NSDate().timeIntervalSince1970)
    }
    
    public func isValid(requestFactory: RequestFactory, completion: @escaping (Bool) -> Void) {
        guard let token = token else {
            completion(false)
            return
        }
        requestFactory.setToken(token: token)
        let profileFactory = requestFactory.makeProfileFactory(errorParser: ErrorParser())
        profileFactory.get { response in
            switch response.result {
            case .success(let model):
                completion(model.status == "ok")
            case .failure:
                completion(false)
            }
        }
    }
}
