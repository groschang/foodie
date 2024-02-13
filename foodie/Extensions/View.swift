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

    func styleNavigationStack() -> some View {
        tint(.accent)
    }

    func styleNavigationBar() -> some View {
        //TODO: make custom top toolbar
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black

        return navigationBarColor(backgroundColor: .toolbar,
                                  titleColor: .white)
        .tint(.accent)
    }

    func hideNavigationBar() -> some View {
        toolbar(.hidden, for: .navigationBar)
    }
}

extension View {

    func hidden(_ hide: Bool) -> some View {
        opacity( hide ? 0 : 1 )
    }
}


// QUICK SOLUTION: Enable back getsture in views that has navigation bar hidden
extension UINavigationController: UIGestureRecognizerDelegate {

    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}


extension View {

    func placeAtTheTop() -> some View {
        VStack(spacing: .zero) {
            self
            Spacer()
        }
    }

    func placeAtTheBottom() -> some View {
        VStack(spacing: .zero) {
            Spacer()
            self
        }
    }

    func placeAtTheRight() -> some View {
        HStack(spacing: .zero) {
            Spacer()
            self
        }
    }
    
    func placeAtTheLeft() -> some View {
        HStack(spacing: .zero) {
            self
            Spacer()
        }
    }

}


extension View {

    func frameWithRatio43(_ width: CGFloat) -> some View {
        frame(
            width: width,
            height: width / 4.0 * 3.0
        )
    }

    func frameWithRatio16to9(_ width: CGFloat) -> some View {
        frame(
            width: width,
            height: width / 16.0 * 9.0
        )
    }
}
