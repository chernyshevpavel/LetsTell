//
//  FiltersStorage.swift
//  LetsTell
//
//  Created by Павел Чернышев on 30.05.2021.
//

import Foundation

enum FiltersType: String {
    case language = "LANGUAGE"
    case ganre = "GANRE"
}

typealias FilterValue = Int

protocol ApplyedFiltersStorage {
    func get(forUser userId: String) -> [ApplyedFiltersStorageModel]
    func save(forUser userId: String, filters: [ApplyedFiltersStorageModel])
}
