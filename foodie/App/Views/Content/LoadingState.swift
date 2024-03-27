//
//  LoadingState.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import Foundation

enum LoadingStateError: Error {
    case base(String)
}

enum LoadingState: Hashable, Identifiable, RawRepresentable, Equatable {

    case idle
    case loading
    case failed(Error?)
    case empty
    case loaded

    init?(rawValue: String) {
        switch rawValue {
        case "idle":
            self = .idle
        case "loading":
            self = .loading
        case let str where rawValue.contains("failed"):
            self = .failed(LoadingStateError.base(str))
        case "empty":
            self = .empty
        case "loaded":
            self = .loaded
        default:
            return nil
        }
    }

    var id: String {
        rawValue
    }

    var rawValue: String {
        switch self {
        case .idle: return "idle"
        case .loading: return "loading"
        case .failed(_): return "failed"
        case .empty: return "empty"
        case .loaded: return "loaded"
        }
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: LoadingState, rhs: LoadingState) -> Bool {
        var same: Bool

        switch (lhs, rhs) {
        case (.idle, .idle): same = true
        case (.loading, .loading): same = true
        case (.failed(_), .failed(_)): same = true
        case (.empty, .empty): same = true
        case (.loaded, .loaded): same = true
        default: same = false
        }

        return same
    }
}

extension LoadingState {

    mutating func setCollection(_ items: some Collection) {
        self = state(for: items)
    }

    mutating func set(for items: some Collection) {
        self = state(for: items)
    }

    func state(for items: some Collection) -> LoadingState {
        var state: LoadingState

        if items.isEmpty { /// self != .loaded &&
            state = .empty
        } else {
            state = .loaded
        }

        return state
    }
}

extension LoadingState {

    mutating func set(for item: some ContainsElements) {
        self = state(for: item)
    }

    func state(for items: some ContainsElements) -> LoadingState {
        var state: LoadingState

        if items.isEmpty { /// self != .loaded &&
            state = .empty
        } else {
            state = .loaded
        }

        return state
    }
}

extension LoadingState {

    var isLoading: Bool { self == .loading }

    mutating func setLoading() {
        self = .loading
    }

    var isLoaded: Bool { self == .loaded }

    mutating func setLoaded() {
        self = .loaded
    }

    var isError: Bool { self == .failed(nil) }

    /// Sets `failed` loading state with related `error`
    ///
    /// > Important: This is bussiness logic driven method. If data is loaded
    /// > (or cached) do not set failure state.
    /// > Show the data that was previously loaded instead.
    ///
    /// - Parameters:
    ///     - error: An error that is cause of failure
    ///
    mutating func setError(_ error: Error? = nil) {
        if self.isLoaded == false {
            self = .failed(error)
        }
    }

    var isEmpty: Bool { self == .empty }

    mutating func setEmpty() {
        self = .empty
    }
}


extension LoadingState: CaseIterable {
    static var allCases: [LoadingState] {
        [.idle, .loading, .failed(nil), .empty, .loaded]
    }
}
