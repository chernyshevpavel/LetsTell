//
//  StoryRequestFactory.swift
//  LetsTell
//
//  Created by Павел Чернышев on 18.04.2021.
//

import Foundation
import Alamofire

class StoryRequestFactory: AbstractRequestFactory {
    
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

extension StoryRequestFactory: StoryRequstFactoryProtocol {
    
    func getSteps(story id: String, completionHandler: @escaping (AFDataResponse<BodyResponse<[StoryStep]>>) -> Void) {
        let requestModel = StoryStepsRequestRouter(id: id, baseUrl: baseUrl)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension StoryRequestFactory {
    struct StoryStepsRequestRouter: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String
        
        var parameters: Parameters?
        
        init(id: String, baseUrl: URL) {
            self.baseUrl = baseUrl
            path = "library/\(id)/steps"
        }
    }
}
