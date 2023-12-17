//
//  DependencyContainer.swift
//  foodie
//
//  Created by Konrad Groschang on 09/05/2023.
//

import Foundation


protocol DependencyContainerType {

    associatedtype CategoriesViewModelAssociatedType: CategoriesViewModelType
    associatedtype CategoriesViewFactoryAssociatedType: ViewBuilderProtocol //TODO: check to change to any TheViewBuilder below

    var container: DIContainer { get }

    var backendClient: HTTPClient { get }
    var persistenceClient: PersistenceClient { get }
    var closureService: MealsClosureServiceType { get }
    var asyncService: MealsAsyncServiceType { get }
    var asyncStreamService: MealsAsyncStreamServiceType { get }
    var passthroughCombineService: MealsPassthroughCombineServiceType { get }

    var router: Router { get }

    var categoriesViewModel: CategoriesViewModelAssociatedType { get }
    var categoriesViewFactory: CategoriesViewFactoryAssociatedType { get }

    func assemble()
}

struct DependencyContainer: DependencyContainerType {

    let container = DIContainer()

    var backendClient: HTTPClient { container.resolve(type: HTTPClient.self)! }
    var persistenceClient: PersistenceClient { container.resolve(type: PersistenceClient.self)! }
    var closureService: MealsClosureServiceType { container.resolve(type: MealsClosureServiceType.self)! }
    var asyncService: MealsAsyncServiceType { container.resolve(type: MealsAsyncServiceType.self)! }
    var asyncStreamService: MealsAsyncStreamServiceType { container.resolve(type: MealsAsyncStreamServiceType.self)! }
    var passthroughCombineService: MealsPassthroughCombineServiceType { container.resolve(type: MealsPassthroughCombineServiceType.self)! }
    var router: Router { container.resolve(type: Router.self)! }
    var categoriesViewModel: CategoriesViewModel { container.resolve(type: CategoriesViewModel.self)! }
    var categoriesViewFactory: CategoriesViewFactory { container.resolve(type: CategoriesViewFactory.self)! }

    func assemble() {
        container.register(type: HTTPClient.self) { _ in
            APIClient()
        }

        container.register(type: PersistenceClient.self) { _ in
            CoreDataClient()
        }

        container.register(type: MealsClosureServiceType.self) { _ in
            MealsClosureService(backendClient: backendClient, persistanceClient: persistenceClient)
        }

        container.register(type: MealsAsyncServiceType.self) { _ in
            MealsAsyncService(backendClient: backendClient, persistanceClient: persistenceClient)
        }
        
        container.register(type: MealsAsyncStreamServiceType.self) { _ in
            MealsAsyncStreamService(backendClient: backendClient, persistanceClient: persistenceClient)
        }

        container.register(type: MealsPassthroughCombineServiceType.self) { _ in
            MealsPassthroughCombineService(backendClient: backendClient, persistanceClient: persistenceClient)
        }

        container.register(type: Router.self) { _ in
            Router()
        }

        container.register(type: CategoriesViewModel.self) { _ in
            CategoriesViewModel(service: closureService)
        }

        container.register(type: CategoriesViewFactory.self) { _ in
            CategoriesViewFactory(service: closureService)
        }
    }
}


struct MockedDependencyContainer: DependencyContainerType {

    let container = DIContainer()

    var backendClient: HTTPClient { container.resolve(type: HTTPClient.self)! }
    var persistenceClient: PersistenceClient { container.resolve(type: PersistenceClient.self)! }
    var closureService: MealsClosureServiceType { container.resolve(type: MealsClosureServiceType.self)! }
    var asyncService: MealsAsyncServiceType { container.resolve(type: MealsAsyncServiceType.self)! }
    var asyncStreamService: MealsAsyncStreamServiceType { container.resolve(type: MealsAsyncStreamServiceType.self)! }
    var passthroughCombineService: MealsPassthroughCombineServiceType { container.resolve(type: MealsPassthroughCombineServiceType.self)! }
    var router: Router { container.resolve(type: Router.self)! }
    var categoriesViewModel: CategoriesViewModelMock { container.resolve(type: CategoriesViewModelMock.self)! }
    var categoriesViewFactory: CategoriesViewFactory { container.resolve(type: CategoriesViewFactory.self)! }

    func assemble() {
        container.register(type: HTTPClient.self) { _ in
            APIClient()
        }

        container.register(type: PersistenceClient.self) { _ in
            CoreDataClient() //TODO: make mock?
        }

        container.register(type: MealsClosureServiceType.self) { _ in
            MealsServiceMock()
        }

        container.register(type: MealsAsyncServiceType.self) { _ in
            MealsServiceAsyncMock()
        }

        container.register(type: MealsAsyncStreamServiceType.self) { _ in
            MealsAsyncStreamService(backendClient: backendClient, persistanceClient: persistenceClient) //TODO: make mock?
        }

        container.register(type: MealsPassthroughCombineServiceType.self) { _ in
            MealsPassthroughCombineService(backendClient: backendClient, persistanceClient: persistenceClient) //TODO: make mock?
        }

        container.register(type: Router.self) { _ in
            Router()
        }

        container.register(type: CategoriesViewModelMock.self) { _ in
            CategoriesViewModelMock(service: closureService)
        }

        container.register(type: CategoriesViewFactory.self) { _ in
            CategoriesViewFactory(service: closureService)
        }
    }
}


struct DependencyInjectionContainer: DependencyContainerType { //TODO: check

    let container = DIContainer()

    var backendClient: HTTPClient { container.resolve(type: HTTPClient.self)! }
    var persistenceClient: PersistenceClient { container.resolve(type: PersistenceClient.self)! }
    var closureService: MealsClosureServiceType { container.resolve(type: MealsClosureServiceType.self)! }
    var asyncService: MealsAsyncServiceType { container.resolve(type: MealsAsyncServiceType.self)! }
    var asyncStreamService: MealsAsyncStreamServiceType { container.resolve(type: MealsAsyncStreamServiceType.self)! }
    var passthroughCombineService: MealsPassthroughCombineServiceType { container.resolve(type: MealsPassthroughCombineServiceType.self)! }
    var router: Router { container.resolve(type: Router.self)! }
    var categoriesViewModel: CategoriesViewModel { container.resolve(type: CategoriesViewModel.self)! }
    var categoriesViewFactory: CategoriesViewFactory { container.resolve(type: CategoriesViewFactory.self)! }

    func assemble() {
        container.register(type: HTTPClient.self) { _ in
            APIClient()
        }

        container.register(type: PersistenceClient.self) { _ in
            CoreDataClient()
        }

        container.register(type: MealsClosureServiceType.self) { _ in
            MealsServiceMock()
        }

        container.register(type: MealsAsyncServiceType.self) { _ in
            MealsAsyncService(backendClient: backendClient, persistanceClient: persistenceClient)
        }

        container.register(type: MealsAsyncStreamServiceType.self) { _ in
            MealsAsyncStreamService(backendClient: backendClient, persistanceClient: persistenceClient)
        }

        container.register(type: MealsPassthroughCombineServiceType.self) { _ in
            MealsPassthroughCombineService(backendClient: backendClient, persistanceClient: persistenceClient)
        }

        container.register(type: Router.self) { _ in
            Router()
        }

        container.register(type: CategoriesViewModel.self) { _ in
            CategoriesViewModel(service: closureService)
        }

        container.register(type: CategoriesViewFactory.self) { _ in
            CategoriesViewFactory(service: closureService)
        }
    }
}
