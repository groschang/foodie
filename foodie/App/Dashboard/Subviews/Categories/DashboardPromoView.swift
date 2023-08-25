//
//  DashboardPromoView.swift
//  foodie
//
//  Created by Konrad Groschang on 15/07/2023.
//

import SwiftUI

struct DashboardPromoView<ViewModel: DashboardPromoViewModelType>: View {

    @StateObject private var viewModel: ViewModel

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
        .maxSize()
        .background(ColorStyle.appColor)
        .cornerRadius(32)
        .padding()
        .shadow(radius: 2)
    }

    private var imageLayer: some View {
        HStack(spacing: 0) {
            Spacer()

            VStack(spacing: 0) {
                ListPhotoView(imageUrl: viewModel.imageUrl)
                    .modifier(ListPhotoStyle(width: 200, height: 200))
                    .mask(SideGradient(startPoint: .leading))
            }
        }
    }

    private var textLayer: some View {
        HStack {
            VStack(alignment: .leading) {

                Text("Foodie of the day")
                    .foregroundColor(.white)
                    .title()

                Text(viewModel.name)
                    .foregroundColor(.white)
                    .title3()

                AsyncButton("Show next", action: viewModel.load)
                    .buttonStyle(DashboardButton())
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
