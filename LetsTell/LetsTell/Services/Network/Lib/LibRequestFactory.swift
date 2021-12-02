//
//  LibRequestFactory.swift
//  LetsTell
//
//  Created by Павел Чернышев on 24.05.2021.
//

import Foundation
import Alamofire

class LibRequestFactory: AbstractRequestFactory {
    
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl: URL
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility),
        baseUrl: URL
    ) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
        self.baseUrl = baseUrl
    }
}

extension LibRequestFactory: LibRequestFactoryProtocol {
    func genres(completionHandler: @escaping (AFDataResponse<BodyResponse<[Genre]>>) -> Void) {
        let requestModel = GenresRequestRouter(baseUrl: baseUrl)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func languages(completionHandler: @escaping (AFDataResponse<BodyResponse<[Language]>>) -> Void) {
        let requestModel = LanguagesRequestRouter(baseUrl: baseUrl)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension LibRequestFactory {
    struct GenresRequestRouter: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "/lib/genres/"
        var parameters: Parameters?
    }
    
    struct LanguagesRequestRouter: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "/lib/languages/"
        var parameters: Parameters?
    }
}
