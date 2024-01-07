//
//  ButtonStyles.swift
//  foodie
//
//  Created by Konrad Groschang on 15/07/2023.
//

import SwiftUI

// MARK: DashboardButtonStyle

struct DashboardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
            .foregroundStyle(AppStyle.main)
            .background(.white)
            .subtitle()
            .clipShape(Capsule())
    }
}

extension ButtonStyle where Self == DashboardButtonStyle {
    static var dashboard: Self { .init() }
}


// MARK: GrowingButtonStyle

struct GrowingButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.interpolatingSpring(duration: 0.25), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == GrowingButtonStyle {
    static var growing: Self { .init() }
}

// MARK: Information button

struct InformationButtonStyle: ButtonStyle {

    private struct Animations {
        static let endScale = 1.2
        static let duration = 0.2
        static let startScale = 1.0
    }

    private struct Colors {
        static let background = AppStyle.gray
        static let foreground = AppStyle.white
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundStyle(AppStyle.foreground)
            .background(Colors.background)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? Animations.endScale : Animations.startScale)
            .animation(.easeOut(duration: Animations.duration), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == InformationButtonStyle {
    static var information: Self { .init() }
}

// MARK: Information button

struct MenuButtonStyle: ButtonStyle {

    private struct Animations {
        static let endScale = 1.2
        static let duration = 0.2
        static let startScale = 1.0
    }

    private struct Colors {
        static let background = AppStyle.gray
        static let backgroundPressed = AppStyle.orange
        static let foreground = AppStyle.white
        static let foregroundPressed = AppStyle.light
    }

    var selected: Bool

    init(selected: Bool = false) {
        self.selected = selected
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal)
            .padding(.vertical, 8)
            .foregroundStyle(
                configuration.isPressed ? Colors.foreground : Colors.foregroundPressed
            )
            .background(
                configuration.isPressed || selected ? Colors.backgroundPressed : Colors.background
            )
            .clipShape(Capsule())
            .scaleEffect(
                configuration.isPressed ? Animations.endScale : Animations.startScale
            )
            .animation(.easeOut(duration: Animations.duration), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == MenuButtonStyle {
    static var menu: Self { .init() }
    static func menu(selected: Bool) -> Self { .init(selected: selected) }
}


// MARK: Previews

struct ButtonStyles_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button("DashboardButton"){}
                .buttonStyle(.dashboard)

            Button("GrowingButton"){}
                .buttonStyle(.growing)

            Button("InformationButtonStyle"){}
                .buttonStyle(.information)

            Button("MenuButtonStyle"){}
                .buttonStyle(.menu)
        }
    }
}
