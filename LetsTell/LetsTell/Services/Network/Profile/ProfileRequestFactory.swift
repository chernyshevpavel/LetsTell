//
//  ProfileRequestFactory.swift
//  LetsTell
//
//  Created by Павел Чернышев on 30.03.2021.
//

import Foundation
import Alamofire

class ProfileRequestFactory: AbstractRequestFactory {
    
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

extension ProfileRequestFactory: ProfileRequestFactoryProtocol {
    func get(completionHandler: @escaping (AFDataResponse<BodyResponse<Owner>>) -> Void) {
        let requestModel = ProfileRequestRouter(baseUrl: baseUrl)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension ProfileRequestFactory {
    struct ProfileRequestRouter: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "profile/"
        var parameters: Parameters?
    }
}
