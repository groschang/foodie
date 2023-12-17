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
    var service: MealsServiceType { get }
    var serviceV: MealsServiceAsyncType { get }
    var serviceNew: MealsServiceTypeNew { get }

    var router: Router { get }

    var categoriesViewModel: CategoriesViewModelAssociatedType { get }
    var categoriesViewFactory: CategoriesViewFactoryAssociatedType { get }

    func assemble()
}

struct DependencyContainer: DependencyContainerType {

    let container = DIContainer()

    var backendClient: HTTPClient { container.resolve(type: HTTPClient.self)! }
    var persistenceClient: PersistenceClient { container.resolve(type: PersistenceClient.self)! }
    var service: MealsServiceType { container.resolve(type: MealsServiceType.self)! }
    var serviceV: MealsServiceAsyncType { container.resolve(type: MealsServiceAsyncType.self)! }
    var serviceNew: MealsServiceTypeNew { container.resolve(type: MealsServiceTypeNew.self)! }
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

        container.register(type: MealsServiceType.self) { _ in
            MealsService(backendClient: backendClient, persistanceClient: persistenceClient)
        }

        container.register(type: MealsServiceAsyncType.self) { _ in
            MealsServiceAsync(backendClient: backendClient, persistanceClient: persistenceClient)
        }

        container.register(type: MealsServiceTypeNew.self) { _ in
            MealsServiceNew(backendClient: backendClient, persistanceClient: persistenceClient)
        }

        container.register(type: Router.self) { _ in
            Router()
        }

        container.register(type: CategoriesViewModel.self) { _ in
            CategoriesViewModel(service: serviceV)
        }

        container.register(type: CategoriesViewFactory.self) { _ in
            CategoriesViewFactory(service: service, asyncService: serviceV) // MealsServiceTypeNew
        }
    }
}


struct MockDependencyContainer: DependencyContainerType {

    let container = DIContainer()

    var backendClient: HTTPClient { container.resolve(type: HTTPClient.self)! }
    var persistenceClient: PersistenceClient { container.resolve(type: PersistenceClient.self)! }
    var service: MealsServiceType { container.resolve(type: MealsServiceType.self)! }
    var serviceV: MealsServiceAsyncType { container.resolve(type: MealsServiceAsyncType.self)! }
    var serviceNew: MealsServiceTypeNew { container.resolve(type: MealsServiceTypeNew.self)! }
    var router: Router { container.resolve(type: Router.self)! }
    var categoriesViewModel: CategoriesViewModelMock { container.resolve(type: CategoriesViewModelMock.self)! }
    var categoriesViewFactory: CategoriesViewFactory { container.resolve(type: CategoriesViewFactory.self)! }

    func assemble() {
        container.register(type: HTTPClient.self) { _ in
            APIClient()
        }

        container.register(type: PersistenceClient.self) { _ in
            CoreDataClient()
        }

        container.register(type: MealsServiceType.self) { _ in
            MealsServiceMock()
        }

        container.register(type: MealsServiceAsyncType.self) { _ in
            MealsServiceAsyncMock()
        }

        container.register(type: MealsServiceTypeNew.self) { _ in
            MealsServiceNew(backendClient: backendClient, persistanceClient: persistenceClient) //TODO?
        }

        container.register(type: Router.self) { _ in
            Router()
        }

        container.register(type: CategoriesViewModelMock.self) { _ in
            CategoriesViewModelMock(service: service)
        }

        container.register(type: CategoriesViewFactory.self) { _ in
            CategoriesViewFactory(service: service, asyncService: serviceV)
        }
    }
}


struct DependencyInjectionContainer: DependencyContainerType {

    let container = DIContainer()

    var backendClient: HTTPClient { container.resolve(type: HTTPClient.self)! }
    var persistenceClient: PersistenceClient { container.resolve(type: PersistenceClient.self)! }
    var service: MealsServiceType { container.resolve(type: MealsServiceType.self)! }
    var serviceV: MealsServiceAsyncType { container.resolve(type: MealsServiceAsyncType.self)! }
    var serviceNew: MealsServiceTypeNew { container.resolve(type: MealsServiceTypeNew.self)! }
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

        container.register(type: MealsServiceType.self) { _ in
            MealsServiceMock()
        }

        container.register(type: MealsServiceAsyncType.self) { _ in
            MealsServiceAsync(backendClient: backendClient, persistanceClient: persistenceClient)
        }

        container.register(type: MealsServiceTypeNew.self) { _ in
            MealsServiceNew(backendClient: backendClient, persistanceClient: persistenceClient)
        }

        container.register(type: Router.self) { _ in
            Router()
        }

        container.register(type: CategoriesViewModel.self) { _ in
            CategoriesViewModel(service: serviceV)
        }

        container.register(type: CategoriesViewFactory.self) { _ in
            CategoriesViewFactory(service: service, asyncService: serviceV)
        }
    }
}
