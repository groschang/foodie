//
//  ParallaxManager.swift
//  foodie
//
//  Created by Konrad Groschang on 05/09/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation
import Combine
import Spatial

@MainActor
class ParallaxManager: ObservableObject {

    @Published var position: Point3D = .zero

    @Published private(set) var isEmiting: Bool = false

    private(set) var privatePosition: Point3D = .zero {
        didSet {
            if isEmiting {
                position = privatePosition
            }
        }
    }

    private(set) var centerPosition: Point3D?

    private var motion = MotionManager()

    private var cancellables = Set<AnyCancellable>()

    init() {
        setupObservables()
    }

    private func setupObservables() {
        motion.$attitude
            .receive(on: RunLoop.main)
            .sink { [weak self] attitude in
                guard
                    let self,
                    let attitude
                else { return }

                let value = Point3D(x: attitude.pitch,
                                    y: attitude.roll,
                                    z: attitude.yaw)

                self.privatePosition = value

                Log.log("x: \(value.x)\ty: \(value.y)\tz: \(value.z)", onLevel: .verbose)

                if centerPosition.isNil {
                    self.centerPosition = privatePosition
                }

                if let calibration = self.centerPosition {
                    self.privatePosition -= calibration
                }
            }
            .store(in: &cancellables)
    }

    func add(offset: CGPoint) {
        DispatchQueue.main.async { [weak self] in
            self?.position.x += offset.y
            self?.position.y += offset.x
        }
    }

    func add(offset: Point3D) {
        DispatchQueue.main.async { [weak self] in
            self?.position += offset
        }
    }

    func start() {
        startEmiting()
        observeMotion()
    }

    func stop() {
        stopEmiting()
        stopObserveMotion()
    }

    func startEmiting() {
        DispatchQueue.main.async { [weak self] in
            self?.isEmiting = true
        }
    }

    func stopEmiting() {
        DispatchQueue.main.async { [weak self] in
            self?.isEmiting = false
        }
    }

    func reset() {
        stopObserveMotion()
        observeMotion()
    }

    func updatePosition() {
        position = privatePosition
    }

    private func observeMotion() {
        motion.startUpdating()
    }

    private func stopObserveMotion() {
        motion.stopUpdating()
        resetPosition()
    }

    private func resetPosition() {
        DispatchQueue.main.async { [weak self] in
            self?.centerPosition = nil
        }
    }
}
