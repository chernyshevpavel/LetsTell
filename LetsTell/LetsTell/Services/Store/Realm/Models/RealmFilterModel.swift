//
//  RealmFilterModel.swift
//  LetsTell
//
//  Created by Павел Чернышев on 30.05.2021.
//

import Foundation
import RealmSwift

class RealmFilterModel: Object {
    
    @objc dynamic var userId: String = ""
    @objc dynamic var filterType: String = ""
    @objc dynamic var filterValue: FilterValue = 0
    
    override init() {}
    
    init(userId: String, filterType: FiltersType, filterValue: FilterValue) {
        self.userId = userId
        self.filterType = filterType.rawValue
        self.filterValue = filterValue
    }
}
