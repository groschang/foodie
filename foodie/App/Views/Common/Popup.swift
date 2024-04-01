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

    private var currentOffset: CGFloat {
        isPresented ? displayedOffset : hiddenOffset
    }

    private var displayedOffset: CGFloat {
        -presenterFrame.midY + screenHeight/2
    }

    private var hiddenOffset: CGFloat {
        if presenterFrame.isEmpty {
            return UIScreen.main.bounds.size.height*2
        }
        return screenHeight - presenterFrame.midY + sheetFrame.height/2
    }

    private var screenWidth: CGFloat {
        UIScreen.main.bounds.size.width
    }

    private var screenHeight: CGFloat {
        UIScreen.main.bounds.size.height
    }

    init(isPresented: Binding<Bool>,
         content: @escaping () -> PopupContent) {
        self._isPresented = isPresented
        self.contentView = content
    }

    public func body(content: Content) -> some View {
        ZStack {
            content
                .readingGeometry(from: CoordinateSpace.alert, into: $presenterFrame)
        }
        .overlay(dimmedBackground)
        .overlay(sheet)
    }

    private var sheet: some View {
        ZStack {
            self.contentView()
                .onTapGesture(perform: dismiss)
                .readingGeometry(from: CoordinateSpace.alert, into: $sheetFrame)
                .frame(width: screenWidth)
                .offset(x: .zero, y: currentOffset)
                .animation(.easeOut(duration: 0.3), value: currentOffset)
        }
    }

    private var dimmedBackground: some View {
        Rectangle()
            .foregroundStyle(Color.gray.lightOpacity())
            .frame(width: screenWidth, height: screenHeight)
            .ignoresSafeArea()
            .opacity(isPresented ? 1.0 : 0.0)
            .animation(.easeOut(duration: 0.3), value: currentOffset)
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
