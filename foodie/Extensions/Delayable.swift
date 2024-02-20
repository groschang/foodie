//
//  Delayable.swift
//  foodie
//
//  Created by Konrad Groschang on 19/01/2023.
//

import Foundation

protocol SleepableProtocol { //TODO: rename Delayable
    var delayDuration: Duration? { get }
    func sleep() async throws
}

extension SleepableProtocol {
    var delayDuration: Duration? { .seconds(0.5) }
    
    func sleep() async {
        if let delayDuration {
            try? await Task.sleep(for: delayDuration)
        }
    }
}

class Sleepable: SleepableProtocol {

    enum Timing {
        static let delay = Duration.seconds(4)
    }

    let delayDuration: Duration?

    init(delayDuration: Duration? = nil) {
        self.delayDuration = delayDuration
    }

    convenience init(delay: Bool) {
        let duration = delay ? Timing.delay : .zero
        self.init(delayDuration: duration)
    }
}


