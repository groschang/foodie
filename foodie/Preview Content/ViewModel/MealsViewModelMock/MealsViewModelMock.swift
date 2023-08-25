//
//  MealsViewModelMock.swift
//  foodie
//
//  Created by Konrad Groschang on 04/02/2023.
//

import Foundation

protocol MealsViewModelMockType: MealsViewModelType, Mock { }

class MealsViewModelMock: MealsViewModelMockType {

    var mockType: MockType { .normal }

    var itemsHeader: String { "\(itemsCount) RECIPES".localized }
    
    @Published var state: LoadingState = .idle
    
    @Published var items: [MealCategory] = []
    var isEmpty: Bool { items.isEmpty }
    
    @Published private(set) var filteredItems: [MealCategory] = [] {
        didSet { itemsCount = filteredItems.count }
    }
    @Published var searchQuery: String = ""
    @Published private(set) var itemsCount: Int = .zero
    
    @Published var categoryName: String = ""
    @Published var description: String = ""
    @Published var backgroundUrl: URL?

    let category: Category
    let service: MealsServiceType //TODO: rename

    init(category: Category = .mock, service: MealsServiceType = MealsServiceMock()) {
        self.category = category
        self.service = service

        setup(category: category)
    }
    
    @MainActor func load() async {
        guard let meals = try? await service.getMeals(for: category, handler: nil).items else { return }

        self.items = meals
        self.filteredItems = meals
        self.state = .loaded
    }

    private func setup(category: Category) {
        categoryName = category.name
        description = category.description
        backgroundUrl = category.imageUrl
    }
}

final class MealsViewModelDeleyedMock: MealsViewModelMock {

    override var mockType: MockType { .delayed }

    override init(category: Category = .mock, service: MealsServiceType = MealsServiceMock(delay: true)) {
        super.init(category: category, service: service)
    }
}

final class MealsViewModelEmptyMock: MealsViewModelMock {

    override var mockType: MockType { .empty }

    override func load() async {
        self.state = .empty
    }
}

final class MealsViewModelLoadingMock: MealsViewModelMock {

    override var mockType: MockType { .loading }

    override func load() async {
        state = .loading
    }
}

final class MealsViewModelErrorMock: MealsViewModelMock {

    override var mockType: MockType { .error }

    override func load() async {
        state = .failed(ApiError.badURL("this.is.sample.url"))
    }
}
