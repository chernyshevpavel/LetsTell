//
//  Created by Павел Чернышев on 13.03.2021
//

import Foundation
import Alamofire

class RequestFactory {

    let baseUrl: URL

    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        var headers: HTTPHeaders = .default
        headers.add(HTTPHeader(name: "Accept-Language", value: Locale.current.languageCode ?? ""))
        configuration.headers = headers
        let manager = Session(configuration: configuration)
        return manager
    }()
    
    var sessionQueue = DispatchQueue.global(qos: .utility)

    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }

    func setToken(token: Token) {
        let sessionConfiguration = commonSession.sessionConfiguration
        sessionConfiguration.headers.add(
            name: "Authorization",
            value: "\(token.tokenType) \(token.accessToken)")
        self.commonSession = Session(configuration: sessionConfiguration)
    }
    
    func makeErrorParser() -> AbstractErrorParser {
        ErrorParser()
    }

    func makeAuthRequestFactory(errorParser: AbstractErrorParser) -> AuthRequestFactory {
        Authorization(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue, baseUrl: baseUrl)
    }
    
    func makeProfileFactory(errorParser: AbstractErrorParser) -> ProfileRequestFactoryProtocol {
        ProfileRequestFactory(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue, baseUrl: baseUrl)
    }
    
    func makeFeedFactory(errorParser: AbstractErrorParser) -> FeedRequestFactoryProtocol {
        FeedRequestFactory(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue, baseUrl: baseUrl)
    }
    
    func makeStoryRequestFactory(errorParser: AbstractErrorParser) -> StoryRequstFactoryProtocol {
         StoryRequestFactory(errorParser: errorParser, sessionManager: commonSession, baseUrl: baseUrl)
    }
    
    func makeLibRequestFactory(errorParser: AbstractErrorParser) -> LibRequestFactoryProtocol {
         LibRequestFactory(errorParser: errorParser, sessionManager: commonSession, baseUrl: baseUrl)
    }
    
}
