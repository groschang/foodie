//
//  ViewBuilderProtocol.swift
//  foodie
//
//  Created by Konrad Groschang on 04/10/2023.
//

import SwiftUI

protocol ViewBuilderProtocol {
    associatedtype V: View
    associatedtype Item: Codable
    associatedtype NoDataView: View
    func makeView() -> V
    func makeView(item: Item) -> V
    func makeEmptyView() -> NoDataView
}

extension ViewBuilderProtocol {
    func makeView() -> V {
        EmptyView() as! V
    }
}

extension ViewBuilderProtocol {
    func makeView(item: String) -> V {
        EmptyView() as! V
    }
}

extension ViewBuilderProtocol {
    func makeEmptyView() -> NoDataView {
        EmptyView() as! NoDataView
    }
}

extension ViewBuilderProtocol {

    @MainActor
    func makeInformationView(message: String) -> some View {
        InformationView(message: message)
            .ignoresSafeArea()
    }

    @MainActor
    func makeEmptyView(message: String) -> some View {
        EmptyScreenView(message)
            .ignoresSafeArea()
    }
}
