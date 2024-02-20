////
////  CategoriesViewModelMock.swift
////  foodie
////
////  Created by Konrad Groschang on 09/02/2023.
////
//
//import Foundation
//
//protocol CategoriesViewModelMockType: CategoriesViewModelType, Mock { }
//
//class CategoriesViewModelMock: CategoriesViewModelMockType {
//
//    var mockType: MockType { .normal }
//
//    var title: String { "Meals".localized }
//
//    @Published var state: LoadingState = .idle
//    var isEmpty: Bool { items.isEmpty }
//
//    @Published var items: [Category] = []
//    @Published var filteredItems: [Category] = []
//    @Published var searchQuery: String = ""
//
//    let service: MealsClosureServiceType
//
//    init(service: MealsClosureServiceType = MealsServicePreview()) {
//        self.service = service
//    }
//
//    @MainActor func load() async {
//        guard let categories = try? await service.getCategories(handler: nil) else { return }
//
//        self.items = categories.items
//        self.filteredItems = categories.items
//        self.state = .loaded
//    }
//}
//
//final class CategoriesViewModelDelayedMock: CategoriesViewModelMock {
//
//    override var mockType: MockType { .delayed }
//
//    init()  {
//        super.init(service: MealsServicePreview(delay: true))
//    }
//}
//
//final class CategoriesViewModelEmptyMock: CategoriesViewModelMock {
//
//    override var mockType: MockType { .empty }
//
//    override func load() async {
//        state = .empty
//    }
//}
//
//final class CategoriesViewModelLoadingMock: CategoriesViewModelMock {
//
//    override var mockType: MockType { .loading }
//
//    override func load() async {
//        state = .loading
//    }
//}
//
//final class CategoriesViewModelErrorMock: CategoriesViewModelMock {
//
//    override var mockType: MockType { .error }
//
//    override func load() async {
//        state = .failed(APIError.badURL("this.is.sample.url"))
//    }
//}
