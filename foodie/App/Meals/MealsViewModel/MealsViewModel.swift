//
//  MealsViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 18/01/2023.
//

import Foundation
import Combine

protocol MealsLocalizable {
    var itemsHeader: String { get }
}

protocol MealsItems: ObservableObject {
    var items: [MealCategory] { get }
}

protocol MealsSearchable: SearchableItems where T == MealCategory {
    var itemsCount: Int { get }
}

protocol MealsPresentable: ObservableObject {
    var categoryName: String { get }
    var description: String { get }
    var backgroundUrl: URL? { get }
}

protocol MealsViewModelType: LoadableObject, MealsLocalizable, MealsItems, MealsPresentable, MealsSearchable { }

final class MealsViewModel: MealsViewModelType {

    var itemsHeader: String { "\(itemsCount) RECIPES".localized }

    @Published var state: LoadingState = .idle
    var isEmpty: Bool { items.isEmpty }

    @Published private(set) var items: [MealCategory] = []

    @Published private(set) var filteredItems: [MealCategory] = []
    @Published var searchQuery: String = ""
    @Published private(set) var itemsCount: Int = .zero

    @Published private(set) var categoryName: String = ""
    @Published private(set) var description: String = ""
    @Published private(set) var backgroundUrl: URL?

    private let category: Category
    private let service: MealsServiceType

    private var cancellables = Set<AnyCancellable>()

    init(service: MealsServiceType, category: Category) {
        self.service = service
        self.category = category
        setupProperties()
        setupSubscriptions()
    }

    func load() async {
        await fetchMeals()
    }

    private func setupProperties() {
        categoryName = category.name
        description = category.description
        backgroundUrl = category.imageUrl
    }

    private func setupSubscriptions() {
        $items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.filterItems()
            }
            .store(in: &cancellables)

        $searchQuery
            .receive(on: DispatchQueue.main)
            .sink { [weak self] textQuery in
                self?.filterItems(with: textQuery)
            }
            .store(in: &cancellables)
    }

    private func filterItems(with query: String? = nil) {
        filteredItems = filter(query: query) { $0.name }
        itemsCount = filteredItems.count // :)
    }

    private func fetchMeals() async {
        guard state.isLoading == false else { return }

        do {
            try await getMeals()
        } catch {
            Logger.log("Fetch meals error: \(error)", onLevel: .error)
            state.setError(error)
        }
    }

    @MainActor private func getMeals() async throws {
        state = .loading

        let meals = try await service.getMeals(for: category) { [weak self] storedMeals in
            guard let self else { return }

            if storedMeals.isEmpty == false {
                self.state.setLoaded()
                self.items = storedMeals.items
            }
        }

        items = meals.items
        state = meals.isEmpty ? .empty : .loaded
    }
}
