//
//  DependencyContainer.swift
//  foodie
//
//  Created by Konrad Groschang on 09/05/2023.
//

import Foundation

final class DependencyContainer: DependencyContainerType {

    static let shared = DependencyContainer()

    private init() { }

    private let container = DIContainer()

    var backendClient: HTTPClient { container.resolve(HTTPClient.self)! }
    var persistenceClient: PersistenceClient { container.resolve(PersistenceClient.self)! }

    var closureService: MealsClosureServiceType { container.resolve(MealsClosureServiceType.self)! }
    var asyncService: MealsAsyncServiceType { container.resolve(MealsAsyncServiceType.self)! }
    var asyncStreamService: MealsAsyncStreamServiceType { container.resolve(MealsAsyncStreamServiceType.self)! }
    var passthroughCombineService: MealsPassthroughCombineServiceType { container.resolve(MealsPassthroughCombineServiceType.self)! }

    var router: Router { container.resolve(Router.self)! }
    var viewFactory: StreamViewFactory { container.resolve(StreamViewFactory.self)! }

    func assemble() {
        container.register(HTTPClient.self) { _ in
            APIClient()
        }

#if MOCKED || NORMAL
        container.register(PersistenceClient.self) { _ in
            CoreDataClient() //TODO: make stubs?
        }
#elseif SWIFTDATA
        container.register(PersistenceClient.self) { _ in
            do {
                return try SwiftDataClient()
            } catch {
                Log.error("Couldn't initialize Swift Data Client: \(error)")
                return SwiftDataClientLogger()
            }
        }
#endif

        container.register(MealsClosureServiceType.self) { r in
            MealsClosureService(
                backendClient: r.resolve(HTTPClient.self)!,
                persistanceClient: r.resolve(PersistenceClient.self)!
            )
        }

        container.register(MealsAsyncServiceType.self) { r in
            MealsAsyncService(
                backendClient: r.resolve(HTTPClient.self)!,
                persistanceClient: r.resolve(PersistenceClient.self)!
            )
        }

        container.register(MealsAsyncStreamServiceType.self) { r in
            MealsAsyncStreamService(
                backendClient: r.resolve(HTTPClient.self)!,
                persistanceClient: r.resolve(PersistenceClient.self)!
            )
        }

        container.register(MealsPassthroughCombineServiceType.self) { r in
            MealsPassthroughCombineService(
                backendClient: r.resolve(HTTPClient.self)!,
                persistanceClient: r.resolve(PersistenceClient.self)!
            )
        }

        container.register(StreamViewFactory.self) { r in
            StreamViewFactory(service: r.resolve(MealsAsyncStreamServiceType.self)!)
        }


        container.register(Router.self) { _ in
            Router()
        }
    }
}
