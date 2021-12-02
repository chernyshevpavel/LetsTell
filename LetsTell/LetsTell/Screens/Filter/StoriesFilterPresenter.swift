//
//  StoriesFilterPresenter.swift
//  LetsTell
//
//  Created by Павел Чернышев on 26.05.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol StoriesFilterPresentationLogic {
    func presentFilters(response: StoriesFilter.Filters.Response)
    func presentApplying(response: StoriesFilter.Applying.Response)
}

class StoriesFilterPresenter: StoriesFilterPresentationLogic {
    weak var viewController: StoriesFilterDisplayLogic?

    func presentFilters(response: StoriesFilter.Filters.Response) {
        switch response.filters {
        case .success(let filters):
            var filters = filters
            for applyedFilter in response.applyedFilters {
                if let sectionIndex = filters.firstIndex(where: { $0.id == applyedFilter.type }),
                   let rowIndex = filters[sectionIndex].rows.firstIndex(where: { $0.id == applyedFilter.value })
                {
                    filters[sectionIndex].rows[rowIndex].active = true
                }
            }
                
            let viewModel = StoriesFilter.Filters.ViewModel(filtersResult: PresenterResult.success(filters))
            viewController?.displayFilters(viewModel: viewModel)
        case .failure(let error):
            let viewModel = StoriesFilter.Filters.ViewModel(filtersResult: PresenterResult.failure(error.localizedDescription))
            viewController?.displayFilters(viewModel: viewModel)
        }
    }
    
    func presentApplying(response: StoriesFilter.Applying.Response) {
        viewController?.displayApplying(viewModel: .init(filersChanged: response.filersChanged))
    }
    
}
