//
//  BodyResponse.swift
//  LetsTell
//
//  Created by Павел Чернышев on 18.04.2021.
//

import Foundation

// MARK: - BodyResponse
struct BodyResponse<T: Codable>: Codable {
    let body: T
    let status: String
}
