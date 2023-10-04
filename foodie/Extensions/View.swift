//
//  View.swift
//  foodie
//
//  Created by Konrad Groschang on 27/01/2023.
//

import SwiftUI

extension View {
    func embedInNavigationStack() -> some View {
        NavigationStack {
            self
        }
    }
}

extension View {
    func embedInScrollView(alignment: Alignment = .center) -> some View {
        GeometryReader { geometry in
            ScrollView {
                self.frame(
                    minWidth: geometry.size.width,
                    minHeight: geometry.size.height,
                    maxHeight: .infinity,
                    alignment: alignment
                )
            }
        }
    }
}

extension View {
    
    func maxWidth() -> some View {
        frame(maxWidth: .infinity)
    }
    
    func maxHeight() -> some View {
        frame(maxHeight: .infinity)
    }
    
    func maxSize() -> some View {
        maxWidth().maxHeight()
    }
}


extension View {
    
    func navigationBarStyle() -> some View {
        navigationBarColor(Color(UIColor.systemBackground).mediumOpacity())
    }

    func navigationBarHiddenx() -> some View {
        toolbar(.hidden, for: .navigationBar)
    }
}

extension View {

    func hidden(_ hide: Bool) -> some View {
        opacity( hide ? 0 : 1 )
    }
}
