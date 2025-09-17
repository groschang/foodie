//
//  DashboardPromoView.swift
//  foodie
//
//  Created by Konrad Groschang on 15/07/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct DashboardPromoView<ViewModel: DashboardPromoViewModelType>: View {

    @EnvironmentObject var router: Router

    @StateObject private var viewModel: ViewModel

    @ScaledMetric(relativeTo: .title2) var spacing: CGFloat = 8

    private var action: () -> Void

    init(viewModel: ViewModel, action: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.action = action
    }

    var body: some View {
        ZStack {
            imageLayer
            textLayer
        }
        .onTapGesture {
            if let meal = viewModel.meal {
                router.navigate(to: .meal(meal))
            }
        }
        .maxSize()
        .background(AppStyle.main)
        .cornerRadius(32)
        .padding()
        .shadow(radius: 2)
    }

    private var imageLayer: some View {
        HStack(spacing: 0) {
            Spacer()

            VStack(spacing: 0) {
                ListPhotoView(imageUrl: viewModel.imageUrl) {
                    ModernCircularLoader()
                        .tint(AppStyle.white)
                        .scaleEffect(0.5)
                }
                .modifier(ListPhotoStyle(width: 200, height: 200))
                .mask(SideGradient(startPoint: .leading))
            }
        }
    }

    private var textLayer: some View {
        HStack {
            VStack(alignment: .leading, spacing: spacing) {

                Text("Foodie of the day")
                    .foregroundStyle(AppStyle.white)
                    .title()

                Text(viewModel.name)
                    .foregroundStyle(AppStyle.white)
                    .title3()

                AsyncButton("Show next", action: viewModel.load)
                    .buttonStyle(.dashboard)
                    .padding(.vertical)
            }
            .padding()

            Spacer()
        }
    }
}

// MARK: Preview

struct DashboardPromoView_Previews: PreviewProvider {

    static let viewModel = DashboardPromoViewModel.mock

    static var previews: some View {
        DashboardPromoView(viewModel: viewModel) { }
            .task { await viewModel.load() }
            .maxWidth()
            .frame(maxHeight: 200)
    }
}
