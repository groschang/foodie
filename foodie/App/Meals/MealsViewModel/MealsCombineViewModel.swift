//
//  MealsCombineViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 07/08/2023.
//

import Foundation
import Combine

final class MealsCombineViewModel: MealsViewModelType {

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
    private let service: MealsServiceCombineType

    private var cancellables = Set<AnyCancellable>()
    private var serviceSubscription: AnyCancellable?

    init(service: MealsServiceCombineType, category: Category) {
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
        state.setLoading()

        serviceSubscription = service.getMeals(for: category)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self else { return }

                    switch completion {
                    case .finished:
                        self.state = self.items.isEmpty ? .empty : .loaded
                    case .failure(let error):
                        self.state.setError(error)
                    }
                },
                receiveValue: { [weak self] meals in
                    guard let self, let meals else { return }

                    if meals.isEmpty == false {
                        self.state.setLoaded()
                    }

                    self.items = meals.items
                })
    }
}
