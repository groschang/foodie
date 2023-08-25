//
//  Delayable.swift
//  foodie
//
//  Created by Konrad Groschang on 19/01/2023.
//

import Foundation

protocol Sleepable {
    var delayDuration: Duration? { get }
    func sleep() async throws
}

extension Sleepable {
    var delayDuration: Duration? { .seconds(2) }
    
    func sleep() async throws {
        if let delayDuration {
            try await Task.sleep(for: delayDuration)
        }
    }
}
