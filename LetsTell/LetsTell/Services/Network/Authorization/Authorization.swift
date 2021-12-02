//
//  Created by Павел Чернышев on 13.03.2021
//

import Foundation
import Alamofire

class Authorization: AbstractRequestFactory {
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

extension Authorization: AuthRequestFactory {
    func refreshToken(completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = RefreshTokenRequestRouter(baseUrl: baseUrl)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func login(email: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, email: email, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Authorization {
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "auth/login/"

        let email: String
        let password: String
        var parameters: Parameters? {
            [
                "email": email,
                "password": password
            ]
        }
    }
    
    struct RefreshTokenRequestRouter: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "auth/refresh/"
        var parameters: Parameters?
    }
}
