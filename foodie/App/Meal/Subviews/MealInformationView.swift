//
//  MealInformationView.swift
//  foodie
//
//  Created by Konrad Groschang on 08/02/2023.
//

import SwiftUI

struct MealInformationView<Model>: View where Model: MealInformations {

    @ObservedObject var viewModel: Model

    var body: some View {
        VStack {
            TitleView(viewModel.name, style: MealInformationTitleStyle())
            TitleView(viewModel.area, style: MealInformationSubtitleStyle())
            TitleView(viewModel.category, style: MealInformationSubtitleStyle())
        }
    }
}


// MARK: Preview

#Preview {
    MealInformationView(viewModel: MealViewModel.stub)
        .previewAsComponent()
}
