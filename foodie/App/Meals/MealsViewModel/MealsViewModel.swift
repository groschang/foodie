//
//  MealsViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 18/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
import Combine

@MainActor
protocol MealsLocalizable {
    var itemsHeader: String { get }
}

@MainActor
protocol MealsItems: ObservableObject {
    var items: [MealCategory] { get }
}

@MainActor
protocol MealsSearchable: SearchableItems where T == MealCategory {
    var itemsCount: Int { get }
}

@MainActor
protocol MealsPresentable: ObservableObject {
    var categoryName: String { get }
    var description: String { get }
    var backgroundUrl: URL? { get }
}

protocol MealsViewModelType: LoadableObject, MealsLocalizable, MealsItems, MealsPresentable, MealsSearchable { }


@MainActor
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

    private var category: any Identifiable
    private let service: MealsClosureServiceType

    private var cancellables = Set<AnyCancellable>()

    init(service: MealsClosureServiceType, category: any Identifiable) {
        self.service = service
        self.category = category

        if category is Category {
            setupProperties()
        }

        setupSubscriptions()
    }

    func load() async {
        guard state.isLoading == false else { return }
        state = .loading

        do {

            if (category is Category) == false {
                try await getCategories()
            }

            if let category = category as? Category {
                try await getMeals(category)
            }

            state.set(for: items) 

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

    @MainActor
    private func getCategories() async throws  {

        @Sendable func assignCategory(_ categories: Categories) {
            Task { @MainActor in
                guard let id = category.id as? String else { return }
                let filteredArray = categories.items.filter { $0.id == id }
                guard let category = filteredArray.first else { return }
                self.category = category
            }
        }

        do {
            let categories = try await service.getCategories() {  [weak self] storedCategories in
                guard self.isNotNil else { return }

                assignCategory(storedCategories)
            }

            assignCategory(categories)

        } catch {
            Logger.log("Fetch meals error: \(error)", onLevel: .error)
            state.setError(error)
        }
    }

    @MainActor
    private func getMeals(_ category: Category) async throws {
        let meals = try await service.getMeals(for: category) { [weak self] storedMeals in
            guard let self else { return }

            Task { @MainActor in
                if storedMeals.isEmpty == false {
                    self.state.setLoaded()
                    self.items = storedMeals.items
                }
            }
        }

        items = meals.items
    }
}


#if DEBUG
extension MealsViewModel {
    static let stub = MealsViewModel(service: MealsServicePreview(), category: Category.stub)
}
#endif
