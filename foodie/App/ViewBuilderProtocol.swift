//
//  ViewBuilderProtocol.swift
//  foodie
//
//  Created by Konrad Groschang on 04/10/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

protocol ViewBuilderProtocol {
    associatedtype V1: View
    associatedtype V2: View
    associatedtype DataView: View
    @MainActor func makeView() -> V2
    @MainActor func makeView(item: any IdentifiableObject) -> V1
    @MainActor func makeEmptyView() -> DataView
}

extension ViewBuilderProtocol {
    func makeView() -> some View {
        EmptyView()
    }

    func makeView(item: any IdentifiableObject) -> some View {
        EmptyView()
    }

    func makeEmptyView() -> some View {
        EmptyView()
    }
}

extension ViewBuilderProtocol {

    @MainActor
    func makeInformationView(message: String) -> some View {
        InformationView(message)
            .ignoresSafeArea()
    }

    @MainActor
    func makeEmptyView(message: String) -> some View {
        EmptyStateView(message)
            .ignoresSafeArea()
    }
}
