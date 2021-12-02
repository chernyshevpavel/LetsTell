//
//  ErrorCodes.swift
//  LetsTell
//
//  Created by Павел Чернышев on 04.04.2021.
//

import Foundation
extension NSError {
    enum ErrorCodes: Int {
        case containerGetObjectError = 10
        case feedNetworkParsedError = 20
        case feedNetworkAFError = 21
        case feedDetailNetworkParsedError = 30
        case feedDetailNetworkAFError = 31
        case filtersNetworkAFError = 41
        case imageNetworkAFError = 100
    }
}
