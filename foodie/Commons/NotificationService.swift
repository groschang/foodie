//
//  NotificationService.swift
//  foodie
//
//  Created by Konrad Groschang on 01/04/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import UIKit
import Combine

@MainActor
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
            .receive(on: DispatchQueue.main)
            .sink { [weak self] content in
                self?.notification = PushNotification(content)
                self?.showNotification = true
            }
    }

    func run() {
        Task {
            do {
                try await notificationManager.requestPermission()
            } catch {
                Log.log("Failed to request notification permission: \(error)", onLevel: .verbose)
            }
        }
    }

    func hideNotification() {
        showNotification = false
        notification = nil
    }
}
