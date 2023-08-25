//
//  DashboardViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 11/07/2023.
//

import Foundation

protocol DashboardViewModelType: ObservableObject {
    var categoriesViewModel: DashboardCategoriesViewModel { get }
    var promoViewModel: DashboardPromoViewModel { get }

    func load() async
}

final class DashboardViewModel: DashboardViewModelType {

    private let service: MealsServiceAsyncType

    private(set) var categoriesViewModel: DashboardCategoriesViewModel
    private(set) var promoViewModel: DashboardPromoViewModel

    init(service: MealsServiceAsyncType) {
        self.service = service
        self.categoriesViewModel = DashboardCategoriesViewModel(service: service)
        self.promoViewModel = DashboardPromoViewModel(service: service)
    }

    func load() async {
        await categoriesViewModel.load()
        await promoViewModel.load()
    }
}


extension DashboardViewModel {
    static let mock = DashboardViewModel(service: MealsServiceVMock())
}
