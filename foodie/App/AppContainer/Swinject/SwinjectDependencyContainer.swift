//
//  SwinjectDependencyContainer.swift
//  foodie
//
//  Created by Konrad Groschang on 12/01/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
#if canImport(Swinject)
import Swinject

actor SwinjectDependencyContainer: DependencyContainerType {

    static let shared = SwinjectDependencyContainer()

    private init() { }

    let container = Container()

    var backendClient: HTTPClient { container.resolve(HTTPClient.self)! }
    var persistenceClient: PersistenceClient { container.resolve(PersistenceClient.self)! }

    var closureService: MealsClosureServiceType { container.resolve(MealsClosureServiceType.self)! }
    var mealsService: MealsAsyncServiceType { container.resolve(MealsAsyncServiceType.self)! }
    var viewFactory: AsyncViewFactory { container.resolve(AsyncViewFactory.self)! }
    var router: Router { container.resolve(Router.self)! }
    var notificationService: NotificationService { container.resolve(NotificationService.self)! }

    func assemble() {
        container.register(HTTPClient.self) { _ in
            APIClient()
        }

#if COREDATA
        container.register(PersistenceClient.self) { _ in
            CoreDataClient()
        }
#elseif REALM
        container.register(PersistenceClient.self) { _ in
            RealmClient()
        }
#else
        container.register(PersistenceClient.self) { _ in
            do {
                return try SwiftDataClient()
            } catch {
                Log.error("Couldn't initialize Swift Data Client: \(error)")
                return SwiftDataClientLogger()
            }
        }
#endif

        container.register(MealsAsyncServiceType.self) { r in
            MealsAsyncService(
                backendClient: r.resolve(HTTPClient.self)!,
                persistanceClient: r.resolve(PersistenceClient.self)!
            )
        }
    }
}

#endif
