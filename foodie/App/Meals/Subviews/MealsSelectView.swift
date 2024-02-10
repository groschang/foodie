//
//  MealsSelectView.swift
//  foodie
//
//  Created by Konrad Groschang on 05/02/2023.
//

import SwiftUI


struct MealsSelectView: View {

    private struct Localizable {
        static let title = "Select category"
    }

    private struct Layout {
        static let spacing = 50.0
    }
    
    var body: some View {
        VStack(spacing: Layout.spacing) {
            Text(Localizable.title)
                .modifier(MealsSelectTitleStyle())
        }
        .modifier(MealsSelectStyle())
    }
}


// MARK: Preview

struct MealsDefaultView_Previews: PreviewProvider {
    static var previews: some View {

        MealsSelectView()

    }
}
