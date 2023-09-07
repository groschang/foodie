//
//  ErrorView.swift
//  foodie
//
//  Created by Konrad Groschang on 18/01/2023.
//

import SwiftUI

struct ErrorView: View {

    private struct Localizable {
        static let title = "Something wrong happen"
        static let button = "Try again"
    }
    
    private let description: String?
    private let action: () async -> Void
    
    init(_ error: Error?, action: @escaping () async -> Void) { //TODO: pass string insted of error
        self.description = error.debugDescription
        self.action = action
    }
    
    var body: some View {
        VStack {
            TextView(Localizable.title, style: ErrorViewTitleStyle())

            if let description = description {
                TextView(description, style: ErrorViewSubtitleStyle())
            }
            
            Button(Localizable.button) {
                Task { await action() }
            }
            .buttonStyle(ErrorViewButtonStyle())
        }
        .maxSize()
        .background { StaticGradient() }
    }
}

// MARK: Previews

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(APIError.noResponse, action: { })
    }
}

// MARK: Styles

struct ErrorViewTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .title()
            .lightOpacity()
            .padding()
    }
}

struct ErrorViewSubtitleStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .subtitle3()
            .italic()
            .padding()
    }
}

struct ErrorViewButtonStyle: ButtonStyle {

    private struct Animations {
        static let endScale = 1.2
        static let duration = 0.2
        static let startScale = 1.0
    }

    private struct Colors {  //TODO: animation button?
        static let background = ColorStyle.gray
        static let foreground = ColorStyle.black
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
