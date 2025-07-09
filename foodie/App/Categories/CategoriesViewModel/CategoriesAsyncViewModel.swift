//
//  CategoriesAsyncViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 17/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
import Combine

final class CategoriesAsyncViewModel: CategoriesViewModelType, Identifiable {

    var title: String { "Meals".localized }

    @Published var state: LoadingState = .idle
    var isEmpty: Bool { items.isEmpty }

    @Published private(set) var items: [Category] = []
    @Published private(set) var filteredItems: [Category] = []
    @Published var searchQuery: String = ""

    private let service: MealsAsyncServiceType

    private var cancellables = Set<AnyCancellable>()

    init(service: MealsAsyncServiceType) {
        self.service = service

        setupSubscriptions()
    }

    func load() async {
        guard state.isLoading == false else { return }
        state.setLoading()

        await loadCategories()
        await getCategories()
    }

    private func setupSubscriptions() {
        $items
            .dropFirst()
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.filterItems()
            }
            .store(in: &cancellables)

        $searchQuery
            .dropFirst()
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] textQuery in
                self?.filterItems(with: textQuery)
            }
            .store(in: &cancellables)
    }

    private func filterItems(with query: String? = nil) {
        filteredItems = filter(query: query) { $0.name }
    }

    private func loadCategories() async {
        if let categories = await service.loadCategories() {
            items = categories.items
            state.setLoaded()
        }
    }

    private func getCategories() async {
        do {
            let categories = try await service.fetchCategories()

            items = categories.items

            state = items.isEmpty ? .empty : .loaded
        } catch {
            Logger.log("Fetch categories error: \(error)", onLevel: .error)
            state.setError(error)
        }
    }
}


#if DEBUG
extension CategoriesAsyncViewModel {
    @MainActor static let stub = CategoriesAsyncViewModel(service: MealsAsyncServicePreview())
}
#endif
