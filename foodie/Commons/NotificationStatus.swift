//
//  NotificationStatus.swift
//  foodie
//
//  Created by Konrad Groschang on 24/03/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import UIKit
import Combine

class NotificationStatus {

    var status: AnyPublisher<UNAuthorizationStatus, Never> {
        statusSubject.eraseToAnyPublisher()
    }

    private let statusSubject = CurrentValueSubject<UNAuthorizationStatus, Never>(.notDetermined)

    private let notificationCenter: UNUserNotificationCenter

    init(notificationCenter: UNUserNotificationCenter = .current()) {
        self.notificationCenter = notificationCenter

        Task {
            await authorizationStatus()
        }
    }

    @discardableResult
    func authorizationStatus() async -> UNAuthorizationStatus  {
        await withCheckedContinuation { continuation in
            notificationCenter.getNotificationSettings { [weak self] settings in
                self?.statusSubject.send(settings.authorizationStatus)
                continuation.resume(returning: settings.authorizationStatus)
            }
        }
    }

    func refreshStatus() async {
        await authorizationStatus()
    }
}
