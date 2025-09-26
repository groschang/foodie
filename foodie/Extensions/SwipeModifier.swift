//
//  SwipeModifier.swift
//  foodie
//
//  Created by Konrad Groschang on 05/09/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct SwipeModifier: ViewModifier {

    @ObservedObject var manager: ParallaxManager

    @State private var viewSize: CGSize = .zero

    @State var location: CGPoint = .zero
    
    @GestureState private var isDragging = false

    init(manager: ParallaxManager) {
        self.manager = manager
        manager.startEmiting()
    }

    func body(content: Content) -> some View {
        content
            .size(in: $viewSize)
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .updating($isDragging) { (value, state, transaction) in
                        guard isDragging else {
                            state = true
                            manager.stopEmiting()
                            return
                        }

                        let offset = value.shift
                        let percentRelativeOffset = offset.inSize(viewSize)
                        manager.add(offset: percentRelativeOffset)
                    }
                    .onEnded { value in
                        withAnimation {
                            manager.updatePosition()
                        }
                    }
            )
            .simultaneousGesture(
                TapGesture()
                    .onEnded {
                        withAnimation {
                            manager.reset()
                        }
                    }
            )
            .onAnimationCompleted(for: manager.position) {
                withAnimation {
                    manager.startEmiting()
                }
            }
    }
}


extension DragGesture.Value {
    
    var shift: CGPoint {
        location - startLocation
    }
}
