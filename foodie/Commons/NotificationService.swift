//
//  NotificationService.swift
//  foodie
//
//  Created by Konrad Groschang on 01/04/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import UIKit
import Combine

final class NotificationService: ObservableObject {

    @Published private(set) var notification: PushNotification?
    @Published var showNotification = false

    private let notificationManager: NotificationManager

    private var cancellable: AnyCancellable?

    init(notificationManager: NotificationManager = .shared) {
        self.notificationManager = notificationManager

        initialize()
    }

    private func initialize() {
        cancellable = notificationManager.notificationPublisher
            .sink { [weak self] in
                self?.notification = PushNotification($0)
                self?.showNotification = true
            }
    }

    func run() {
        Task {
           try? await notificationManager.requestPermission()
        }
    }

    func hideNotification() {
        self.showNotification = false
        self.notification = nil
    }

}
