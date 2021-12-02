//
//  FeedRequestFactory.swift
//  LetsTell
//
//  Created by Павел Чернышев on 02.04.2021.
//

import Foundation
import Alamofire

class FeedRequestFactory: AbstractRequestFactory {
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

extension FeedRequestFactory: FeedRequestFactoryProtocol {
    func get(page: Int, filters: FeedRequestFilters? = nil, complition: @escaping (AFDataResponse<FeedResponse>) -> Void) {
        let requestModel = FeedRequestRouter(baseUrl: baseUrl, page: page, filters: filters)
    
        self.request(request: requestModel, completionHandler: complition)
    }
}

extension FeedRequestFactory {
    struct FeedRequestRouter: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "feed/"
        var applyedFilters: FeedRequestFilters?
        var page: Int
        
        init( baseUrl: URL, page: Int, filters: FeedRequestFilters?) {
            self.baseUrl = baseUrl
            self.applyedFilters = filters
            self.page = page
        }
        
        var encoding: RequestRouterEncoding = .url
        var parameters: Parameters? {
            
            var dictionary: [String: Any] = [
                "page": page
            ]
            
            guard let applyedFilters = applyedFilters else {
                return dictionary
            }
            
            var filters: [String: Any] = [:]
            if let languageId = applyedFilters.languageId {
                filters["language_id"] = languageId
            }
            if let genreId = applyedFilters.genreId {
                filters["genre_id"] = genreId
            }
            
            if !filters.isEmpty {
                dictionary["filters"] = filters
            }
            
            return dictionary
        }
    }
}
