//
//  ScrollView.swift
//  foodie
//
//  Created by Konrad Groschang on 25/01/2023.
//

import SwiftUI

struct PointPreferenceKey: PreferenceKey {
    typealias Value = CGPoint
    
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}

struct ScrollViewOffsetModifier: ViewModifier {
    
    let coordinateSpace: String
    @Binding var offset: CGPoint
    
    func body(content: Content) -> some View {
        ZStack {
            content
            GeometryReader { proxy in
                let x = proxy.frame(in: .named(coordinateSpace)).minX
                let y = proxy.frame(in: .named(coordinateSpace)).minY
                Color.clear.preference(
                    key: PointPreferenceKey.self,
                    value: CGPoint(
                        x: -x,
                        y: -y
                    )
                )
            }
        }
        .onPreferenceChange(PointPreferenceKey.self) { value in
            offset = value
        }
    }
}

extension View {

    func readScrollView(from coordinateSpace: String, into binding: Binding<CGPoint>) -> some View {
        modifier(ScrollViewOffsetModifier(coordinateSpace: coordinateSpace, offset: binding))
    }

    func readScrollView(from coordinateSpace: CustomStringConvertible, into binding: Binding<CGPoint>) -> some View {
        modifier(ScrollViewOffsetModifier(coordinateSpace: coordinateSpace.description, offset: binding))
    }
    
}
