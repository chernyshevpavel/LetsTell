//
//  ProfileRequestFactory.swift
//  LetsTell
//
//  Created by Павел Чернышев on 30.03.2021.
//

import Foundation
import Alamofire

protocol ProfileRequestFactoryProtocol {
    func get(completionHandler: @escaping (AFDataResponse<BodyResponse<Owner>>) -> Void)
}
