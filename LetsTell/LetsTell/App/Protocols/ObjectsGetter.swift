//
//  ObjectsGetter.swift
//  LetsTell
//
//  Created by Павел Чернышев on 16.05.2021.
//

import Foundation

protocol ObjectsGetter {
    func getObject<T>() -> T
}
