//
//  DashboardSearchView.swift
//  foodie
//
//  Created by Konrad Groschang on 07/01/2024.
//

import SwiftUI

struct DashboardSearchView: View {


    enum ElementID {
        static let textfield = "Textfield"
        static let background = "Background"
        static let chin = "Chin"
    }

    var namespace: Namespace.ID

    @Binding var show: Bool

    @FocusState var isFocused: Bool


    var body: some View {
        VStack {
            ZStack {

                content

                header
                    .placeAtTheTop()
            }
        }
        .onAppear {
            isFocused = true
        }
        .onDisappear {
            isFocused = false
        }
    }

    private var header: some View {
        VStack {
            DashboardTextfiledView(isFocused: $isFocused, type: .reversed)
                .matchedGeometryEffect(id: ElementID.textfield,
                                       in: namespace)
        }
        .padding()
        .padding(.bottom, AppStyle.cornerRadius)
        .background(
            Color.red
                .matchedGeometryEffect(id: ElementID.background,
                                       in: namespace)
                .ignoresSafeArea(edges: .top)
                .padding(.bottom, AppStyle.cornerRadius)
                .onTapGesture(perform: toggleVisibility)
        )
        .overlay {
            Color.red
                .matchedGeometryEffect(id: ElementID.chin,
                                       in: namespace)
                .frame(height: AppStyle.cornerRadius)
                .defaultCornerRadius(corners: .bottom)
                .defaultShadow()
                .mask(Rectangle().padding(.bottom, -AppStyle.cornerRadius))
                .placeAtTheBottom()
        }
    }

    private var content: some View {
        List {
            ForEach(1...20, id: \.self) { item in
                Text("Item: \(item)")
            }
        }
        .offset(y: 100)
        .placeholder(generate: true)
    }

    private func toggleVisibility() {
        withAnimation(AppStyle.Animations.transition) {
            show.toggle()
        }
    }
}


#Preview {

    @Namespace var namespace
    @State var show: Bool = true

    return DashboardSearchView(
        namespace: namespace,
        show: $show
    )
}
