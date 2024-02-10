//
//  DashboardMealsViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 09/02/2024.
//

import Foundation
import Combine

protocol DashboardMealsLocalizable {
    var title: String { get }
}

protocol DashboardMealsItems: ObservableObject {
    var items: [Meal] { get }
}

protocol DashboardMealsViewModelType: LoadableObject, DashboardMealsLocalizable, DashboardMealsItems { }

final class DashboardMealsViewModel: DashboardMealsViewModelType, Identifiable {

    var title: String { "Meals".localized }

    @Published var state: LoadingState = .idle
    var isEmpty: Bool { items.isEmpty }

    @Published private(set) var items: [Meal] = []
    private let service: MealsAsyncServiceType

    private var cancellables = Set<AnyCancellable>()

    init(service: MealsAsyncServiceType) {
        self.service = service
    }

    @MainActor func load() async {
        guard state.isLoading == false else { return }
        state.setLoading()
        await fetchMeals()
    }

    @MainActor private func fetchMeals() async {
        do {

            // Lookup a selection of 10 random meals (only available to Paypal supporters)
            let maxTries = 20
            let itemsToShow = 10
            var tries = 0

            while items.count < itemsToShow && tries < maxTries {

                let meal = try await service.fetchRandomMeal()

                tries += 1

                if items.contains(meal) { continue }

                items.append(meal)
            }

#if MOCK
            guard tries < maxTries || items.isEmpty else {
                state.setEmpty()
                return
            }
#endif

            state.setLoaded()

        } catch {
            Logger.log("Fetch categories error: \(error)", onLevel: .error)
            state.setError(error)
        }
    }
}

extension DashboardMealsViewModel {
    static let mock = DashboardMealsViewModel(service: MealsAsyncServiceMock())
}
