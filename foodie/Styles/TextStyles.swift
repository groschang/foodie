//
//  TextStyles.swift
//  foodie
//
//  Created by Konrad Groschang on 19/02/2023.
//

import SwiftUI


struct TextStyle { }


// MARK: Title

extension TextStyle {
    static let title = TextStyle.Title.Title()

    static let title2 = TextStyle.Title.Title2()

    static let title3 = TextStyle.Title.Title3()
}

extension View {
    func title() -> some View { modifier(TextStyle.title) }

    func title2() -> some View { modifier(TextStyle.title2) }

    func title3() -> some View { modifier(TextStyle.title3) }
}

extension TextStyle {

    struct Title {

        private struct BaseTitle: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .fontWeight(.regular)

            }
        }

        struct Title: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .modifier(BaseTitle())
                    .font(.largeTitle)

            }
        }

        struct Title2: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .modifier(BaseTitle())
                    .font(.title2)
            }
        }

        struct Title3: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .modifier(BaseTitle())
                    .font(.title3)
            }
        }
    }
}


// MARK: Subtitle

extension TextStyle {
    static let subtitle = TextStyle.Subtitle.Subtitle()

    static let subtitle2 = TextStyle.Subtitle.Subtitle2()

    static let subtitle3 = TextStyle.Subtitle.Subtitle3()
}

extension View {
    func subtitle() -> some View { modifier(TextStyle.subtitle) }

    func subtitle2() -> some View { modifier(TextStyle.subtitle2) }

    func subtitle3() -> some View { modifier(TextStyle.subtitle3) }
}

extension TextStyle {

    struct Subtitle {

        private struct BaseSubtitle: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .fontWeight(.regular)
                    .foregroundStyle(AppStyle.gray)
            }
        }

        struct Subtitle: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .modifier(BaseSubtitle())
                    .font(.headline)
            }
        }

        struct Subtitle2: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .modifier(BaseSubtitle())
                    .font(.callout)
            }
        }

        struct Subtitle3: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .modifier(BaseSubtitle())
                    .font(.caption)
            }
        }
    }
}


// MARK: App Styles

extension TextStyle {
    static let infoScreenTitle = TextStyle.InformationScreen.ScreenTitle()

    static let infoScreenSubtitle = TextStyle.InformationScreen.ScreenSubtitle()
}

extension View {
    func infoScreenTitle() -> some View { modifier(TextStyle.infoScreenTitle) }

    func infoScreenSubtitle() -> some View { modifier(TextStyle.infoScreenSubtitle) }
}

extension TextStyle {

    struct InformationScreen {

        struct ScreenTitle: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .title()
                    .lighterOpacity()
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }

        struct ScreenSubtitle: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .subtitle3()
                    .foregroundStyle(AppStyle.lightBlack)
                    .italic()
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
    }
}




// MARK: Preview

struct TextStyles_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            Text("TitleTextStyle").modifier(TextStyle.title)
            Text("Title2TextStyle").modifier(TextStyle.title2)
            Text("Title3TextStyle").modifier(TextStyle.title3)

            Text("SubtitleTextStyle").modifier(TextStyle.subtitle)
            Text("Subtitle2TextStyle").modifier(TextStyle.subtitle2)
            Text("Subtitle3TextStyle").modifier(TextStyle.subtitle3)
        }
    }
}

//public enum TextStyle : CaseIterable {
//
//    /// The font style for large titles.
//    case largeTitle
//
//    /// The font used for first level hierarchical headings.
//    case title
//
//    /// The font used for second level hierarchical headings.
//    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
//    case title2
//
//    /// The font used for third level hierarchical headings.
//    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
//    case title3
//
//    /// The font used for headings.
//    case headline
//
//    /// The font used for subheadings.
//    case subheadline
//
//    /// The font used for body text.
//    case body
//
//    /// The font used for callouts.
//    case callout
//
//    /// The font used in footnotes.
//    case footnote
//
//    /// The font used for standard captions.
//    case caption
//
//    /// The font used for alternate captions.
//    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
//    case caption2
//
