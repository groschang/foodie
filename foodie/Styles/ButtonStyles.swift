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

// MARK: Information button

struct InformationButtonStyle: ButtonStyle {

    private struct Animations {
        static let endScale = 1.2
        static let duration = 0.2
        static let startScale = 1.0
    }

    private struct Colors { 
        static let background = ColorStyle.gray
        static let foreground = ColorStyle.white
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(Colors.foreground)
            .background(Colors.background)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? Animations.endScale : Animations.startScale)
            .animation(.easeOut(duration: Animations.duration), value: configuration.isPressed)
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
