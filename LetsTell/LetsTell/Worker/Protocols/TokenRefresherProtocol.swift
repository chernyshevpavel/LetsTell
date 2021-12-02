//
//  TokenRefresherProtocol.swift
//  LetsTell
//
//  Created by Павел Чернышев on 16.05.2021.
//

import Foundation

protocol TokenRefresherProtocol {
    func refresh(completion: @escaping (Bool) -> Void)
}
