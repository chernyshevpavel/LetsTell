//
//  TockenCheckerProtocol.swift
//  LetsTell
//
//  Created by Павел Чернышев on 16.05.2021.
//

import Foundation

protocol TockenCheckerProtocol {
    func isExist() -> Bool
    func isAlive() -> Bool
    func isValid(requestFactory: RequestFactory, completion: @escaping (Bool) -> Void)
}
