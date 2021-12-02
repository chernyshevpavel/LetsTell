//
//  NetworkResult.swift
//  LetsTell
//
//  Created by Павел Чернышев on 04.04.2021.
//

import Foundation

@frozen public enum NetworkResult<Success, Failure> where Failure: NSError {
    case success(Success)
    case failure(Failure)
}
