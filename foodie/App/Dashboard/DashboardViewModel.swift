//
//  DashboardViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 11/07/2023.
//

import Foundation

protocol DashboardViewModelPresentable: ObservableObject {
    var categoriesViewModel: DashboardCategoriesViewModel { get }
    var promoViewModel: DashboardPromoViewModel { get }

    func initialize() async
}

protocol DashboardViewModelType: DashboardViewModelPresentable,
                                    LoadableObject,
                                    Initializable { }


final class DashboardViewModel: DashboardViewModelType {

    private let service: MealsAsyncServiceType

    private(set) var categoriesViewModel: DashboardCategoriesViewModel
    private(set) var promoViewModel: DashboardPromoViewModel

    @Published var state: LoadingState = .idle
    var isEmpty: Bool { state != .loaded }

    private var initialized = false

    init(service: MealsAsyncServiceType) {
        self.service = service
        self.categoriesViewModel = DashboardCategoriesViewModel(service: service)
        self.promoViewModel = DashboardPromoViewModel(service: service)
    }

    func initialize() async {
        if initialized == false {
            initialized = !initialized
            await load()
        }
    }

    func load() async {
        await categoriesViewModel.load()
        await promoViewModel.load()
    }
}


extension DashboardViewModel {
    static let mock = DashboardViewModel(service: MealsAsyncServiceMock())
}
