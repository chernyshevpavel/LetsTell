//
//  FilterModel.swift
//  LetsTell
//
//  Created by Павел Чернышев on 26.05.2021.
//

import Foundation

struct FilterModel: Identifiable {
    let id: Int
    let name: String
    let sort = 100
    var active: Bool = false
}
