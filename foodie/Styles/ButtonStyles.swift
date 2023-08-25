//
//  ButtonStyles.swift
//  foodie
//
//  Created by Konrad Groschang on 15/07/2023.
//

import SwiftUI

// MARK: WhiteButton

struct DashboardButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
            .foregroundStyle(ColorStyle.appColor)
            .background(.white)
            .subtitle()
            .clipShape(Capsule())
    }
}


// MARK: GrowingButton

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}


// MARK: Previews

struct ButtonStyles_Previews: PreviewProvider {
    static var previews: some View {
        VStack {

            Button("DashboardButton", action: { })
                .buttonStyle(DashboardButton())

            Button("GrowingButton", action: { })
                .buttonStyle(GrowingButton())


        }
    }
}
