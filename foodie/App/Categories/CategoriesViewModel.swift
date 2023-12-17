//
//  CategoriesViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2023.
//

import Foundation
import Combine

protocol CategoriesLocalizable {
    var title: String { get }
}

protocol CategoriesItems: ObservableObject {
    var items: [Category] { get }
}

protocol CategoriesSearchable: SearchableItems where T == Category { }

protocol CategoriesViewModelType: LoadableObject, CategoriesLocalizable, CategoriesItems, CategoriesSearchable { }

class CategoriesViewModel: CategoriesViewModelType, Identifiable {

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

    @MainActor func load() async {
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

    @MainActor private func loadCategories() async {
        if let categories = await service.loadCategories() {
            items = categories.items
            state.setLoaded()
        }
    }
    
    @MainActor private func getCategories() async {
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



//private let categories = CurrentValueSubject<Categories, Never>(.empty)



//        categories
//            .dropFirst()
//            .removeDuplicates()
//            .receive(on: DispatchQueue.main)
//            .map(\.items)
//            .sink { [weak self] items in
//                self?.setCategories(items)
//            }
//            .store(in: &cancellables)



//    @MainActor private func getCategories() async throws {
//        state.setLoading()
//
//        let categories = try await service.getCategories { [weak self] storedCategories in
//            guard let self else { return }
//
//            if storedCategories.isEmpty == false {
//                self.state.setLoaded() //TODO: czy aby napewno?
//                self.items = storedCategories.items
//            }
//        }
//
//        items = categories.items
//        state = categories.isEmpty ? .empty : .loaded
////        state.setCollection(items)
//    }

//@MainActor private func getCategories() async throws {
//    state.setLoading()
//
//    let categories = try await service.getCategories()
//
//    items = categories.items
//    state = categories.isEmpty ? .empty : .loaded

//        let categoriesPublisher = try service.getCategories()

//        service.getCategories(subject: categories)
//        service.updateCategories(subject: categories)

//        categoriesPublisher
//            .dropFirst()
//            .removeDuplicates()
//            .receive(on: DispatchQueue.main)
//            .map(\.items)
//            .sink { [weak self] items in
//                self?.items = items
//                self?.state = items.isEmpty ? .empty : .loaded
//            }
//            .store(in: &cancellables)

//        categoriesPublisher
//            .dropFirst()
//            .removeDuplicates()
//            .receive(on: DispatchQueue.main)
//            .map(\.items)
//            .assign(to: \.items, on: self)
//            .store(in: &cancellables)
//
//        categoriesPublisher
//            .dropFirst()
//            .removeDuplicates()
//            .receive(on: DispatchQueue.main)
//            .map(\.items.isEmpty)
//            .map{ $0 ? .empty : .loaded }
//            .assign(to: \.state, on: self)
//            .store(in: &cancellables)

//        categoriesPublisher
//            .dropFirst()
//            .removeDuplicates()
//            .receive(on: DispatchQueue.main)
//            .sink { values in
//                print(values)
//            }
//            .store(in: &cancellables)
//}
