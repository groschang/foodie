//
//  MotionManager.swift
//  foodie
//
//  Created by Konrad Groschang on 07/08/2023.
//

import SwiftUI
import CoreMotion

class MotionManager: ObservableObject {

    @Published var attitude: CMAttitude?

    private var manager = CMMotionManager()

    init() {
        self.manager.deviceMotionUpdateInterval = 1/60
    }

    func startUpdating() {
        self.manager.startDeviceMotionUpdates(to: .main) { [weak self] (motionData, error) in
            guard
                let self,
                error.isNil
            else {
                Logger.log(error ?? "Unknown", onLevel: .error)
                return
            }

            self.attitude = motionData?.attitude
        }
    }

    func stopUpdating() {
        self.manager.stopDeviceMotionUpdates()
    }
}

//extension MotionManager {
//
//    var offset: CGPoint {
//        .init(x: roll, y: pitch)
//    }
//
//    func set(offset: CGPoint) {
//        roll = offset.x
//        pitch = offset.y
//    }
//
//    func add(offset: CGPoint) {
//        roll += offset.x
//        pitch += offset.y
//    }
//}
