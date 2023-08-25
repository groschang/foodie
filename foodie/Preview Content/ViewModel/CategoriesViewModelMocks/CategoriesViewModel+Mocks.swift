//
//  CategoriesViewModel+Mocks.swift
//  foodie
//
//  Created by Konrad Groschang on 14/05/2023.
//

import Foundation


extension CategoriesViewModel {
    static let mock = CategoriesViewModelMock()
    static let delayedMock = CategoriesViewModelDelayedMock()
    static let emptyMock = CategoriesViewModelEmptyMock()
    static let loadingMock = CategoriesViewModelLoadingMock()
    static let errorMock = CategoriesViewModelErrorMock()
}

extension CategoriesViewModel {
    static let mocks: [any CategoriesViewModelMockType] = [
        CategoriesViewModel.mock,
        CategoriesViewModel.delayedMock,
        CategoriesViewModel.emptyMock,
        CategoriesViewModel.loadingMock,
        CategoriesViewModel.errorMock
    ]
}
