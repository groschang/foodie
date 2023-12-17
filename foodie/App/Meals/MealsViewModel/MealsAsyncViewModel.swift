//
//  MealsAsyncViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 07/08/2023.
//

import Foundation
import Combine

final class MealsAsyncViewModel: MealsViewModelType {

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

    private let category: any IdentifiableObject
    private let service: MealsServiceAsyncType

    private var cancellables = Set<AnyCancellable>()

    init(service: MealsServiceAsyncType, category: any IdentifiableObject) {
        self.service = service
        self.category = category
        setupProperties()
        setupSubscriptions()
    }

    @MainActor func load() async {
        guard state.isLoading == false else { return }
        state.setLoading()

        guard let category = category as? Category else { return } //TODO: check
        await loadMeals(category)
        await fetchMeals(category)
    }

    private func setupProperties() {
        if let category = category as? Category {
            categoryName = category.name
            description = category.description
            backgroundUrl = category.imageUrl
        }
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

    @MainActor private func loadMeals(_ category: Category) async {
        if let meals = await service.getMeals(for: category) {
            items = meals.items
            state.setLoaded()
        }
    }

    @MainActor private func fetchMeals(_ category: Category) async {
        do {
            let meals = try await service.fetchMeals(for: category)

            items = meals.items

            if meals.isEmpty == false {
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


actor dupa: ObservableObject {

    @Published var x = "SS"
}
