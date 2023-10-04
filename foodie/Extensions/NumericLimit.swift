//
//  NumericLimit.swift
//  foodie
//
//  Created by Konrad Groschang on 05/09/2023.
//

import Foundation

fileprivate func MIN<T: Comparable>(_ x: T, _ y: T) -> T { min(x, y) }
fileprivate func MAX<T: Comparable>(_ x: T, _ y: T) -> T { max(x, y) }

protocol NumericLimit {
    associatedtype V
    associatedtype L
    init(_ value: V, limit: L)
    func limit(_ limit: L) -> V
}


extension Int: NumericLimit {

    init(_ value: Int, limit: Int) {
        self = value.limit(limit)
    }

    func limit(_ limit: Int) -> Int {
        self >= .zero
        ? MIN(self, limit)
        : MAX(self, -limit)
    }
}

extension Float: NumericLimit {

    init(_ value: Float, limit: Float) {
        self = value.limit(limit)
    }

    func limit(_ limit: Float) -> Float {
        self >= .zero
        ? MIN(self, limit)
        : MAX(self, -limit)
    }
}


extension Double: NumericLimit {

    init(_ value: Double, limit: Double) {
        self = value.limit(limit)
    }

    func limit(_ limit: Double) -> Double {
        self >= .zero
        ? MIN(self, limit)
        : MAX(self, -limit)
    }
}
