//
//  LibRequestFactoryProtocol.swift
//  LetsTell
//
//  Created by Павел Чернышев on 24.05.2021.
//

import Foundation
import Alamofire

protocol LibRequestFactoryProtocol {
    func genres(completionHandler: @escaping (AFDataResponse<BodyResponse<[Genre]>>) -> Void)
    func languages(completionHandler: @escaping (AFDataResponse<BodyResponse<[Language]>>) -> Void)
}
