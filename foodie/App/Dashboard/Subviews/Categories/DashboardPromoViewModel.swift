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
}

protocol DashboardPromoViewModelType: DashboardPromoPresentable, LoadableObject { }

final class DashboardPromoViewModel: DashboardPromoViewModelType {

    private let service: MealsServiceAsyncType

    @Published private(set) var name: String = ""
    @Published private(set) var imageUrl: URL?

    @Published var state: LoadingState = .idle
    var isEmpty: Bool { state != .loaded }

    init(service: MealsServiceAsyncType) {
        self.service = service
    }

    func load() async {
        await fetchMeal()
    }

    private func fetchMeal() async {
        guard state.isLoading == false else { return }

        do {
            try await getMeal()
        } catch {
            Logger.log("Fetch meal error: \(error)", onLevel: .error)
            state.setError(error)
        }
    }

    @MainActor private func getMeal() async throws {
        state = .loading

        //        let meal = try await service.getMeal(for: mealCaterory.id) {
        //            [unowned self] meal in
        //
        //            if meal.isEmpty == false {
        //                self.state = .loaded
        //                self.setup(with: meal)
        //            }
        //        }

        let meal = [Meal.mock, Meal.mock2].randomElement()! //TODO:

        setup(with: meal)
        state = meal.isEmpty ? .empty : .loaded
    }

    private func setup(with meal: Meal) {
        name = meal.name
        imageUrl = meal.imageURL
    }
}


extension DashboardPromoViewModel {
    static let mock = DashboardPromoViewModel(service: MealsServiceVMock())
}
