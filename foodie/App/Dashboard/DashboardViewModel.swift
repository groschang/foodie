//
//  DashboardViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 11/07/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

@MainActor
protocol DashboardViewModelData: ObservableObject {
    var categoriesViewModel: DashboardCategoriesViewModel { get }
    var mealsViewModel: DashboardMealsViewModel { get }
    var promoViewModel: DashboardPromoViewModel { get }

    func initialize() async
}

protocol DashboardViewModelType: DashboardViewModelData,
                                 LoadableObject,
                                 Initializable { }


final class DashboardViewModel: DashboardViewModelType {

    private let service: MealsAsyncServiceType

    private(set) var categoriesViewModel: DashboardCategoriesViewModel
    private(set) var mealsViewModel: DashboardMealsViewModel
    private(set) var promoViewModel: DashboardPromoViewModel

    @Published var state: LoadingState = .idle
    var isEmpty: Bool { state != .loaded }

    internal var initialized = false

    init(service: MealsAsyncServiceType) {
        self.service = service
        self.categoriesViewModel = DashboardCategoriesViewModel(service: service)
        self.mealsViewModel = DashboardMealsViewModel(service: service)
        self.promoViewModel = DashboardPromoViewModel(service: service)
    }

    func initialize() async {
        if initialized == false {
            initialized = !initialized
            load()
        }
    }

    func load() {
        Task { await categoriesViewModel.load() }
        Task { await mealsViewModel.load() }
        Task { await promoViewModel.load() }
    }
}


extension DashboardViewModel {
    static let mock = DashboardViewModel(service: MealsAsyncServicePreview())
}
