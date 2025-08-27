//
//  Popup.swift
//  foodie
//
//  Created by Konrad Groschang on 29/03/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

public struct Popup<PopupContent>: ViewModifier where PopupContent: View {

    @Binding var isPresented: Bool

    var contentView: () -> PopupContent

    @State private var presenterFrame: CGRect = .zero
    @State private var sheetFrame: CGRect = .zero

    private func currentOffset(with screenHeight: CGFloat) -> CGFloat {
        isPresented ? displayedOffset(with: screenHeight) : hiddenOffset(with: screenHeight)
    }

    private func displayedOffset(with screenHeight: CGFloat) -> CGFloat {
        -presenterFrame.midY + screenHeight/2
    }

    private func hiddenOffset(with screenHeight: CGFloat) -> CGFloat {
        if presenterFrame.isEmpty {
            return screenHeight*2
        }
        return screenHeight - presenterFrame.midY + sheetFrame.height/2
    }

    init(isPresented: Binding<Bool>,
         content: @escaping () -> PopupContent) {
        self._isPresented = isPresented
        self.contentView = content
    }

    public func body(content: Content) -> some View {
        content
            .readingGeometry(from: CoordinateSpace.alert, into: $presenterFrame)
            .overlay(
                GeometryReader { geometry in
                    let screenSize = geometry.size
                    ZStack {
                        dimmedBackground(with: screenSize)
                        sheet(with: screenSize)
                    }
                }
            )
    }

    private func sheet(with screenSize: CGSize) -> some View {
        let offset = currentOffset(with: screenSize.height)
        return ZStack {
            self.contentView()
                .onTapGesture(perform: dismiss)
                .readingGeometry(from: CoordinateSpace.alert, into: $sheetFrame)
                .frame(width: screenSize.width)
                .offset(x: .zero, y: offset)
                .animation(.easeOut(duration: 0.3), value: offset)
        }
    }

    private func dimmedBackground(with screenSize: CGSize) -> some View {
        let offset = currentOffset(with: screenSize.height)
        return Rectangle()
            .foregroundStyle(Color.gray.lightOpacity())
            .frame(width: screenSize.width, height: screenSize.height)
            .ignoresSafeArea()
            .opacity(isPresented ? 1.0 : 0.0)
            .animation(.easeOut(duration: 0.3), value: offset)
            .onTapGesture(perform: dismiss)
    }

    private func dismiss() {
        isPresented = false
    }
}


extension View {

    public func popup<PopupContent: View>(
        isPresented: Binding<Bool>,
        view: @escaping () -> PopupContent) -> some View {
            modifier(
                Popup(isPresented: isPresented, content: view)
            )
        }

    func popup(
        isPresented: Binding<Bool>,
        notification: PushNotification?,
        view: @escaping (PushNotification) -> NotificationView
    ) -> some View {
        if let notification {
            return AnyView(
                self.modifier(
                    Popup(isPresented: isPresented) { view(notification) }
                )
            )
        } else {
            return AnyView(self)
        }
    }
}
