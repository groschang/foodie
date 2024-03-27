//
//  MainActor.swift
//  foodie
//
//  Created by Konrad Groschang on 21/05/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

extension MainActor {

    static func runTask(_ handler: @escaping () -> Void) {
        Task {
            await MainActor.run {
                handler()
            }
        }
    }
}
