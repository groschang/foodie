//
//  MotionManager.swift
//  foodie
//
//  Created by Konrad Groschang on 07/08/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI
import CoreMotion

class MotionManager: ObservableObject {

    @Published var attitude: CMAttitude?

    private var manager = CMMotionManager()

    init() {
        manager.deviceMotionUpdateInterval = 1/60
    }

    func startUpdating() {
        manager.startDeviceMotionUpdates(to: .main) { [weak self] (motionData, error) in
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
        manager.stopDeviceMotionUpdates()
    }
}
