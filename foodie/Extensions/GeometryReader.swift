//
//  GeometryReader.swift
//  foodie
//
//  Created by Konrad Groschang on 08/02/2023.
//

import SwiftUI

struct RectPreferenceKey: PreferenceKey {
    typealias Value = CGRect
    
    static var defaultValue = CGRect()
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

struct GeometryReaderSizeModifier: ViewModifier {
    
    let coordinateSpace: String
    @Binding var rect: CGRect
    
    func body(content: Content) -> some View {
        ZStack {
            content
            GeometryReader { proxy in
                let frame = proxy.frame(in: .named(coordinateSpace))
                Color.clear.preference(
                    key: RectPreferenceKey.self,
                    value: frame
                )
            }
        }
        .onPreferenceChange(RectPreferenceKey.self) { value in
            rect = value
        }
    }
}

extension View {

    func readingGeometry(from coordinateSpace: CustomStringConvertible, into binding: Binding<CGRect>) -> some View {
        modifier(GeometryReaderSizeModifier(coordinateSpace: coordinateSpace.description, rect: binding))
    }
}




