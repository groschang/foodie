//
//  DashboardCategoriesViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 11/07/2023.
//

import Foundation
import Combine

protocol DashboardCategoriesLocalizable {
    var title: String { get }
}

protocol DashboardCategoriesItems {
    var items: [Category] { get }
}

protocol DashboardCategoriesViewModelType: LoadableObject, DashboardCategoriesLocalizable, DashboardCategoriesItems { }


final class DashboardCategoriesViewModel: DashboardCategoriesViewModelType, Identifiable {

    var title: String { "Categories".localized }

    @Published var state: LoadingState = .idle
    var isEmpty: Bool { items.isEmpty }

    @Published private(set) var items: [Category] = []
    private let service: MealsAsyncServiceType

    private var cancellables = Set<AnyCancellable>()

    init(service: MealsAsyncServiceType) {
        self.service = service
    }

    @MainActor func load() async {
        guard state.isLoading == false else { return }
        state.setLoading()

        await loadCategories()
        await fetchCategories()
    }

    @MainActor private func loadCategories() async {
        if let categories = await service.loadCategories() {
            items = categories.items
            state.setLoaded()
        }
    }

    @MainActor private func fetchCategories() async {
        do {
            let categories = try await service.fetchCategories()

            items = categories.items

            if categories.isEmpty == false {
                state.setLoaded()
            } else {
                state.setEmpty()
            }
        } catch {
            Logger.log("Fetch categories error: \(error)", onLevel: .error)
            state.setError(error)
        }
    }
}

extension DashboardCategoriesViewModel {
    static let mock = DashboardCategoriesViewModel(service: MealsAsyncServicePreview())
}
