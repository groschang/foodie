//
//  DashboardPromoViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 15/07/2023.
//

import Foundation

protocol DashboardPromoPresentable: ObservableObject {
    var name: String { get }
    var imageUrl: URL? { get }
    var meal: Meal? { get }
}

protocol DashboardPromoViewModelType: DashboardPromoPresentable,
                                      LoadableObject,
                                      Initializable { }


final class DashboardPromoViewModel: DashboardPromoViewModelType {

    private let service: MealsAsyncServiceType

    @Published private(set) var name: String = ""
    @Published private(set) var imageUrl: URL?
    @Published private(set) var meal: Meal?

    @Published var state: LoadingState = .idle
    var isEmpty: Bool { state != .loaded }

    private(set) var initialized = false

    init(service: MealsAsyncServiceType) {
        self.service = service
    }

    func initialize() async {
        if initialized == false {
            initialized = !initialized
            await load()
        }
    }

    @MainActor func load() async {
        guard state.isLoading == false else { return }
        state.setLoading()

        do {
            let meal = try await service.fetchRandomMeal()
            self.meal = meal

            setup(with: meal)
            state.set(for: meal)
        } catch {
            Logger.log("Fetch meal error: \(error)", onLevel: .error)
            state.setError(error)
        }
    }

    private func setup(with meal: Meal) {
        name = meal.name
        imageUrl = meal.imageURL
    }
}


extension DashboardPromoViewModel {
    static let mock = DashboardPromoViewModel(service: MealsAsyncServicePreview())
}
