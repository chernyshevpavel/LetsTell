//
//  StoryRequstFactoryProtocol.swift
//  LetsTell
//
//  Created by Павел Чернышев on 18.04.2021.
//

import Foundation
import Alamofire

protocol StoryRequstFactoryProtocol {
    func getSteps(story id: String, completionHandler: @escaping (AFDataResponse<BodyResponse<[StoryStep]>>) -> Void)
}
