//
//  MainActor.swift
//  foodie
//
//  Created by Konrad Groschang on 21/05/2023.
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
