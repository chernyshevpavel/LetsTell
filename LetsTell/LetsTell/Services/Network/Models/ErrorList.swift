//
//  ErrorList.swift
//  LetsTell
//
//  Created by Павел Чернышев on 15.03.2021.
//

import Foundation
import Alamofire

struct ErrorList: Codable, Error {
    let status: String
    let errors: [String]
}
