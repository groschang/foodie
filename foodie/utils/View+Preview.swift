//
//  ViewPreview.swift
//  foodie
//
//  Created by Konrad Groschang on 04/02/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct ComponentPreview<Component: View>: View { //TODO: not needed in newer Xcodes

    let component: Component
    let name: String

    var body: some View {
        ForEach(ColorScheme.allCases, id: \.self) { scheme in
            ForEach(ContentSizeCategory.smallestAndLargest, id: \.self) { category in
                component
                    .previewLayout(.sizeThatFits)
                    .background(Color(UIColor.systemBackground))
                    .colorScheme(scheme)
                    .environment(\.sizeCategory, category)
                    .previewDisplayName(
                        "\(name) \(scheme.previewName) + \(category.previewName)"
                    )
            }
        }
    }
}


extension View {

    func previewAsComponent(name: String? = nil) -> some View {
        ComponentPreview(component: self, name: name ?? viewDescribingName)
    }
}


struct ScreenPreview<Screen: View>: View {
    
    let screen: Screen
    let name: String

    var body: some View {
        ForEach(deviceNames, id: \.self) { device in
            ForEach(ColorScheme.allCases, id: \.self) { scheme in
                NavigationView {
                    screen
                }
                .previewDevice(PreviewDevice(rawValue: device))
                .colorScheme(scheme)
                .previewDisplayName("\(name) \(scheme.previewName) \(device)")
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }

    private var deviceNames: [String] {
        [
            "iPhone 8",
            "iPhone 11",
            "iPhone 14 Max",
            "iPhone 14 Pro Max",
            "iPad (7th generation)",
            "iPad Pro (12.9-inch) (4th generation)"
        ]
    }
}


extension View {
    
    func previewAsScreen(name: String? = nil) -> some View {
        ScreenPreview(screen: self, name: name ?? viewDescribingName)
    }
    
    private var viewDescribingName: String {
        String(describing: type(of: self))
            .trimUpTo("<")
    }
}


extension String {

    func trimUpTo(_ character: Character) -> String {
        self.prefix(while: { $0 != character }).toString()
    }
}

extension Substring {

    func toString() -> String {
        String(self)
    }
}


extension ColorScheme {
    
    var previewName: String {
        String(describing: self).capitalized
    }
}


@MainActor
extension ContentSizeCategory {

    static let smallestAndLargest = [allCases.first!, allCases.last!]

    var previewName: String {
        self == Self.smallestAndLargest.first ? "Small" : "Large"
    }
}
