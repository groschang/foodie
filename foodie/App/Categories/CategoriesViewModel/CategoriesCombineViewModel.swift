//
//  CategoriesCombineViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 18/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
import Combine

final class CategoriesCombineViewModel: CategoriesViewModelType, Identifiable {

    var title: String { String(localized: "Meals") }

    @Published var state: LoadingState = .idle
    var isEmpty: Bool { items.isEmpty }

    @Published private(set) var items: [Category] = []
    @Published private(set) var filteredItems: [Category] = []
    @Published var searchQuery: String = ""

    private let service: MealsCombineServiceType

    private var cancellables = Set<AnyCancellable>()
    private var serviceSubscription: AnyCancellable?

    init(service: MealsCombineServiceType) {
        self.service = service

        setupSubscriptions()
    }

    func load() async {
        guard state.isLoading == false else { return }
        state.setLoading()

        await fetchCategories()
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

    private func fetchCategories() async {
        serviceSubscription = service.getCategories()
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self else { return }

                    switch completion {
                    case .finished:
                        self.state.set(for: self.items)
                    case .failure(let error):
                        self.state.setError(error)
                    }
                },
                receiveValue: { [weak self] categories in
                    guard let self, let categories else { return }
                    self.items = categories.items
                })
    }
}
