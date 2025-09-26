//
//  CategoriesAsyncStreamViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 17/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
import Combine

final class CategoriesAsyncStreamViewModel: CategoriesViewModelType, Identifiable {

    var title: String { "Meals".localized }

    @Published var state: LoadingState = .idle
    var isEmpty: Bool { items.isEmpty }

    @Published private(set) var items: [Category] = []
    @Published private(set) var filteredItems: [Category] = []
    @Published var searchQuery: String = ""

    private let service: MealsAsyncStreamServiceType

    private var cancellables = Set<AnyCancellable>()

    init(service: MealsAsyncStreamServiceType) {
        self.service = service

        setupSubscriptions()
    }

    func load() async {
        guard state.isLoading == false else { return }
        state.setLoading()

        do {
            for try await categories in await service.getCategories() {
                items = categories.items
                state.set(for: items) //TODO: test me
            }
        } catch {
            Logger.log("Fetch categories error: \(error)", onLevel: .error)
            state.setError(error)
        }
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
}

//MARK: - Mock

#if DEBUG
extension CategoriesAsyncStreamViewModel {
    @MainActor static let mock = CategoriesAsyncStreamViewModel(service: MealsAsyncStreamServicePreview())
}
#endif
