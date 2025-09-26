//
//  NavigationBarModifier.swift
//  foodie
//
//  Created by Konrad Groschang on 25/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
    
    private(set) var backgroundColor: UIColor?
    private(set) var titleColor: UIColor?
    
    init(_ backgroundColor: Color) {
        self.backgroundColor = UIColor(backgroundColor)
        setup()
    }
    
    init(backgroundColor: Color, titleColor: Color) {
        self.backgroundColor = UIColor(backgroundColor)
        self.titleColor = UIColor(titleColor)
        setup()
    }
    
    func setup() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.backgroundColor = backgroundColor
        if let titleColor {
            navBarAppearance.titleTextAttributes = [.foregroundColor: titleColor]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor]
        }
        
        let appearance = UINavigationBar.appearance()
        appearance.scrollEdgeAppearance = navBarAppearance
        appearance.compactAppearance = navBarAppearance
        appearance.standardAppearance = navBarAppearance
        if #available(iOS 15.0, *) {
            appearance.compactScrollEdgeAppearance = navBarAppearance
        }
    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}


extension View {
    
    func navigationBarColor(_ backgroundColor: Color) -> some View {
        modifier(NavigationBarModifier(backgroundColor))
    }
    
    func navigationBarColor(backgroundColor: Color, titleColor: Color) -> some View {
        modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }
    
}
