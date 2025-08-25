//
//  MealsAsyncStreamViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 17/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
import Combine

final class MealsAsyncStreamViewModel: MealsViewModelType {

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
    private let service: MealsAsyncStreamServiceType

    private var cancellables = Set<AnyCancellable>()

    init(service: MealsAsyncStreamServiceType, category: any IdentifiableObject) {
        self.service = service
        self.category = category
        setupProperties()
        setupSubscriptions()
    }

    @MainActor func load() async {
        guard let category = category as? Category else { return } //TODO: check
        guard state.isLoading == false else { return }

        state.setLoading()

        do {
            for try await meals in await service.getMeals(for: category) {
                items = meals.items
                state.set(for: items)
            }
        } catch {
            Logger.log("Fetch meals error: \(error)", onLevel: .error)
            state.setError(error)
        }
    }

    private func setupProperties() {
        guard let category = category as? Category else { return }

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
}

#if DEBUG
extension MealsAsyncStreamViewModel {
    static let stub = MealsAsyncStreamViewModel(service: MealsAsyncStreamServicePreview(), category: Category.stub)
}
#endif
