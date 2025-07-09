
//
//  ObservableObject.swift
//  foodie
//
//  Created by Konrad Groschang on 7/9/25.
//  Copyright (C) 2025 Konrad Groschang - All Rights Reserved
//

import Combine

extension ObservableObject where Self.ObjectWillChangePublisher == ObservableObjectPublisher {

    func observe<T: ObservableObject>(_ object: T?, storeIn cancellable: inout AnyCancellable?) {
        cancellable = object?.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
    }

    func observe<T: ObservableObject>(_ object: T?, storeIn cancellables: inout Set<AnyCancellable>) {
        object?.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
}
