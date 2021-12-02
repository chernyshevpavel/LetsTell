//
//  RealmFiltersStorage.swift
//  LetsTell
//
//  Created by Павел Чернышев on 30.05.2021.
//

import Foundation
import RealmSwift

class RealmApplyedFiltersStorage: ApplyedFiltersStorage, RealmInitializer {
    
    var logger: ErrorLogger?
    
    func get(forUser userId: String) -> [ApplyedFiltersStorageModel] {
        let list = initRealm().objects(RealmFilterModel.self).filter({ $0.userId == userId })
        let filters: [ApplyedFiltersStorageModel] = list.compactMap({
            guard let filterType = FiltersType.init(rawValue: $0.filterType) else {
                return nil
            }
            return ApplyedFiltersStorageModel(type: filterType, value: $0.filterValue)
        })
        return filters
    }
    
    func save(forUser userId: String, filters: [ApplyedFiltersStorageModel]) {
        let realmFilters: [RealmFilterModel] = filters.map({ RealmFilterModel(userId: userId, filterType: $0.type, filterValue: $0.value) })
        if removeFilters(forUserId: userId) {
            do {
                let realm = initRealm()
                try realm.write {
                    realm.add(realmFilters)
                }
            } catch let error {
                logger?.log(error)
            }
        }
    }
    
    private func removeFilters(forUserId userId: String) -> Bool {
        do {
            let realm = initRealm()
            try realm.write {
                let list = initRealm().objects(RealmFilterModel.self).filter({ $0.userId == userId })
                realm.delete(list)
            }
        } catch let error {
            logger?.log(error)
            return false
        }
        return true
    }
   
}
