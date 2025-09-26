//
//  CategoriesViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
import Combine

@MainActor
protocol CategoriesLocalizable {
    var title: String { get }
}

@MainActor
protocol CategoriesItems: ObservableObject {
    var items: [Category] { get }
}

@MainActor
protocol CategoriesSearchable: SearchableItems where T == Category { }

@MainActor
protocol CategoriesViewModelType: LoadableObject,
                                  CategoriesLocalizable,
                                  CategoriesItems,
                                  CategoriesSearchable { }


@MainActor
class CategoriesViewModel: CategoriesViewModelType, Identifiable {

    var title: String { "Meals".localized }

    @Published var state: LoadingState = .idle
    var isEmpty: Bool { items.isEmpty }
    
    @Published private(set) var items: [Category] = []
    @Published private(set) var filteredItems: [Category] = []
    @Published var searchQuery: String = ""

    private let service: MealsClosureServiceType

    private var cancellables = Set<AnyCancellable>()
    
    init(service: MealsClosureServiceType) {
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
        do {
            let categories = try await service.getCategories() {  [weak self] storedCategories in
                guard let self else { return }
                guard storedCategories.items.isNotEmpty else { return }

                Task { @MainActor in
                    self.items = storedCategories.items
                    self.state.setLoaded()
                }
            }

            self.items = categories.items
            state.set(for: self.items)

        } catch {
            Logger.log("Fetch categories error: \(error)", onLevel: .error)
            state.setError(error)
        }
    }
}

//MARK: - Mock

#if DEBUG
extension CategoriesViewModel {
    @MainActor static let mock = CategoriesViewModel(service: MealsServicePreview())
}
#endif
