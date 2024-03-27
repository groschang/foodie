//
//  MenuViewModel.swift
//  foodie
//
//  Created by Konrad Groschang on 20/12/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI
import Combine

final class MenuViewModel: ObservableObject {

    @AppStorage(UserDefaultsKeys.appTheme) var appTheme: AppTheme = .system

    @Published var notificationsStatus = "Unknown"
    @Published var showEnableNotifications = false
    @Published var showAuthorizeNotifications = false

    private var cancellable: AnyCancellable?

    init() {
        subscribeNotificationStatus()
    }

    func setTheme(_ theme: AppTheme) {
        DispatchQueue.main.async { [weak self] in
            self?.appTheme = theme
        }
    }

    func subscribeNotificationStatus() {
        cancellable = NotificationManager.shared.statusPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                self?.notificationsStatus = status.description
                self?.processNotificationStatus(status)
            }
    }

    func processNotificationStatus(_ status: UNAuthorizationStatus) {
        if status == .denied {
            showEnableNotifications = true
            showAuthorizeNotifications = false
        } else if status == .notDetermined {
            showEnableNotifications = false
            showAuthorizeNotifications = true
        } else if status == .authorized {
            showEnableNotifications = false
            showAuthorizeNotifications = false
        }
    }

    func requestNotificationsPermission() {
        Task {
            do {
                try await NotificationManager.shared.requestPermission()
            } catch {
                Log.debug(error)
            }
        }
    }

    func enableNotificationsInSettings() {
        NotificationHandler.openSettings()
    }
}
