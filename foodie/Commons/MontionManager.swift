//
//  MontionManager.swift
//  foodie
//
//  Created by Konrad Groschang on 07/08/2023.
//

import SwiftUI
import CoreMotion

struct ParallaxMotionModifier: ViewModifier {

    @ObservedObject var manager: MotionManager

    var magnitude: Double

    let degreesLimit = 30.0

    func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(manager.pitch * magnitude, limit: degreesLimit),
                              axis: (x: 1, y: 0, z: 0)
            )
            .rotation3DEffect(.degrees(manager.roll * magnitude, limit: degreesLimit),
                              axis: (x: 0, y: 1, z: 0)
            )
    }
}

struct ParallaxShadowModifier: ViewModifier {

    @ObservedObject var manager: MotionManager

    var radius = 5.0

    var magnitude: Double

    let degreesLimit = 30.0

    func body(content: Content) -> some View {
        content
            .shadow(radius: radius,
                    x: manager.pitch * magnitude,
                    y: manager.roll * -magnitude)
    }
}

extension Angle {

    static func degrees(_ degrees: Double, limit: Double) -> Angle {
        .degrees(
            degrees >= .zero
            ? min(degrees, limit)
            : max(degrees, -limit)
        )
    }
}



class MotionManager: ObservableObject {

    @Published var pitch: Double = 0.0
    @Published var roll: Double = 0.0

    private var manager: CMMotionManager

    init() {
        self.manager = CMMotionManager()
        self.manager.deviceMotionUpdateInterval = 1/60
        self.manager.startDeviceMotionUpdates(to: .main) { [weak self] (motionData, error) in
            guard let self else { return }
            guard error == nil else {
                print(error!)
                return
            }

            if let motionData = motionData {
                self.pitch = motionData.attitude.pitch
                self.roll = motionData.attitude.roll

                //                print("pitch: \(self.pitch) roll: \(self.roll)")
            }
        }

    }
}
