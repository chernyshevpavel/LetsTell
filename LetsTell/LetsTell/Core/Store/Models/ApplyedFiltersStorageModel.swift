//
//  ApplyedFiltersStorageModel.swift
//  LetsTell
//
//  Created by Павел Чернышев on 31.05.2021.
//

import Foundation

struct ApplyedFiltersStorageModel: Equatable, Hashable {
    var type: FiltersType
    var value: FilterValue
}
