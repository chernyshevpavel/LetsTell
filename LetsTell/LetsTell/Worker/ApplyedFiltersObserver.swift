//
//  ApplyedFiltersObserver.swift
//  LetsTell
//
//  Created by Павел Чернышев on 01.06.2021.
//

import Foundation

class ApplyedFiltersObserver: ObservableObject {
    @Published var hasActiveFilters = false
    
    var applyedFiltersStorage: ApplyedFiltersStorage?
    var ownerStorage: OwnerStorage?
    
    public func setup(container: ObjectsGetter) {
        self.applyedFiltersStorage = container.getObject()
        self.ownerStorage = container.getObject()
    }
    
    public func check() {
        guard let ownerStorage = ownerStorage, let owner = ownerStorage.getOwner(), let applyedFiltersStorage = applyedFiltersStorage else {
            return
        }
        let filters = applyedFiltersStorage.get(forUser: owner.id)
        
        let foundActiveFilters = !filters.isEmpty
        
        if hasActiveFilters != foundActiveFilters {
            hasActiveFilters = foundActiveFilters
        }
    }
}
