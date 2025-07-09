//
//  NotificationStatus.swift
//  foodie
//
//  Created by Konrad Groschang on 24/03/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import UIKit
import Combine

final class NotificationStatus: @unchecked Sendable {
    
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
    func authorizationStatus() async -> UNAuthorizationStatus {
        await withCheckedContinuation { continuation in
            notificationCenter.getNotificationSettings { [weak self] settings in
                let status = settings.authorizationStatus
                self?.statusSubject.send(status)
                continuation.resume(returning: status)
            }
        }
    }
    
    func refreshStatus() async {
        await authorizationStatus()
    }
}
