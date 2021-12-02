//
//  FilterSectionModel.swift
//  LetsTell
//
//  Created by Павел Чернышев on 26.05.2021.
//

import Foundation

struct FilterSectionModel: Identifiable {
    var id: FiltersType
    var name: String
    var rows: [FilterModel]
}
