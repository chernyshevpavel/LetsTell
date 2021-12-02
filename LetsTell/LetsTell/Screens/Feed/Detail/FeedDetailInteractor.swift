//
//  FeedDetailInteractor.swift
//  LetsTell
//
//  Created by Павел Чернышев on 19.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol FeedDetailBusinessLogic {
    func loadSteps(request: FeedDetail.Steps.Request)
}

protocol FeedDetailDataStore {
    // var name: String { get set }
}

class FeedDetailInteractor: FeedDetailBusinessLogic, FeedDetailDataStore {
    var presenter: FeedDetailPresentationLogic?
    
    var requestFactory: RequestFactory
    var errorLogger: ErrorLogger?
    var storeToken: TokenStorage
    var authController: AuthViewController
    
    init(requestFactory: RequestFactory, storeToken: TokenStorage, authController: AuthViewController) {
        self.requestFactory = requestFactory
        self.storeToken = storeToken
        self.authController = authController
    }
    
    func loadSteps(request: FeedDetail.Steps.Request) {
        guard let token = storeToken.getToken() else {
            authController.logout()
            return
        }
        requestFactory.setToken(token: token)
        let errorParser = ErrorParserState<ErrorList>()
        let feedFactory = requestFactory.makeStoryRequestFactory(errorParser: errorParser)
        feedFactory.getSteps(story: request.story.id) { response in
            switch response.result {
            case .success(let feedResponse):
                
                let responseForPresenter = FeedDetail.Steps.Response(storySteps: NetworkResult.success(feedResponse))
                self.presenter?.presentStory(response: responseForPresenter)
            case .failure(let error):
                var nsError: NSError?
                if let parsedError = errorParser.parsedError {
                    nsError = NSError(
                        domain: "FeedDetailInteractor",
                        code: NSError.ErrorCodes.feedDetailNetworkParsedError.rawValue,
                        userInfo: ["errors": parsedError.errors.joined(separator: "; ")])
                } else {
                    nsError = NSError(
                        domain: "FeedDetailInteractor",
                        code: NSError.ErrorCodes.feedDetailNetworkAFError.rawValue,
                        userInfo: ["error": error.localizedDescription])
                }
                guard let nsErrorUnwrped = nsError else {
                    return
                }
                self.errorLogger?.log(nsErrorUnwrped)
                let response = FeedDetail.Steps.Response(storySteps: NetworkResult.failure(nsErrorUnwrped))
                self.presenter?.presentStory(response: response)
            }
        }   
    }
}
