//
//  AsyncContentView.swift
//  foodie
//
//  Created by Konrad Groschang on 21/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI
import Combine

struct AsyncContentView<Source: LoadableObject,
                        LoadingContent: View,
                        ErrorContent: View,
                        EmptyContent: View,
                        MainContent: View>: View {
    
    typealias LoadingType = () -> LoadingContent
    typealias ErrorType = (Error?, @escaping (() async -> Void)) -> ErrorContent
    typealias EmptyType = (String) -> EmptyContent
    typealias ContentType = () -> MainContent
    
    @ObservedObject var source: Source
    
    private var loadingView: LoadingType
    private var errorView: ErrorType
    private var emptyView: EmptyType
    private var contentView: ContentType

    init(
        source: Source,
        loading: @escaping LoadingType,
        error: @escaping ErrorType,
        empty: @escaping EmptyType,
        content: @escaping @autoclosure ContentType
    ) {
        self.source = source
        self.loadingView = loading
        self.errorView = error
        self.emptyView = empty
        self.contentView = content
    }
    
    init(
        source: Source,
        content: @escaping @autoclosure ContentType
    )
    where
        LoadingContent == LoadingView,
        ErrorContent == ErrorView,
        EmptyContent == EmptyStateView
    {
        self.source = source
        self.loadingView = { LoadingView() }
        self.errorView = { ErrorView($0?.localizedDescription, action: $1) }
        self.emptyView = { EmptyStateView($0) }
        self.contentView = content
    }
    
    var body: some View {
        ZStack {
            makeLoadedView()
                .hidden(source.state != .loaded)

            stateView
        }
        .refreshable {
            await source.load() //TODO: Sendable?
        }
        .task {
            await source.load()
        }
    }
    
    private var stateView: some View {
        VStack {
            if source.state != .loaded && source.isEmpty {
                switch source.state {
                case .idle:
                    makeIdleView()
                case .loading:
                    makeLoadingView()
                case .failed(let error):
                    makeFailedView(error)
                case .empty:
                    makeEmptyView()
                default:
                    makeIdleView()
                }
            }
        }
        .maxSize()
    }
    
    private func makeIdleView() -> some View {
        Color.clear
    }
    
    private func makeLoadingView() -> some View {
        loadingView()
    }
    
    private func makeFailedView(_ error: Error?) -> some View {
        errorView(error) { await source.load() }
    }
    
    private func makeEmptyView() -> some View {
        emptyView("Empty")
    }
    
    private func makeLoadedView() -> some View {
        contentView()
    }
}


// MARK: Preview

struct AsyncContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
    }

    struct ContentView: View {

        @ObservedObject private var vm = ViewModel()

        var body: some View {
            VStack {

                Picker("State", selection: $vm.state) {
                    ForEach(LoadingState.allCases, id: \.id) { option in
                        Text(option.rawValue)
                            .tag(option)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                AsyncContentView(source: vm, content: content)
                    .navigationTitle(vm.title)

            }
            .alert("Load method fired", isPresented: $vm.showingAlert) {
                Button("OK", role: .cancel) { }
            }
        }

        var content: some View {
            Text(vm.title)
                .maxSize()
                .background(.gray)
        }

    }
    
    private class ViewModel: LoadableObject {

        @Published var state: LoadingState = .idle
        @Published var showingAlert = false
        private var firstRun = false
        var isEmpty: Bool = true
        let title = "Title"

        @MainActor func load() async {
            guard firstRun else {
                firstRun = true
                return
            }
            Task {
                try? await Task.sleep(for: .seconds(2))
                showingAlert = true
            }
        }

    }

}
