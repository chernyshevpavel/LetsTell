//
//  PresenterResult.swift
//  LetsTell
//
//  Created by Павел Чернышев on 27.05.2021.
//

import Foundation

@frozen public enum PresenterResult<Success, Failure> {
    case success(Success)
    case failure(Failure)
}
