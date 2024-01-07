//
//  SwiftUIView.swift
//  foodie
//
//  Created by Konrad Groschang on 08/04/2023.
//

import SwiftUI

struct ListHeader: View {

//    @Environment(\.horizontalSizeClass) var sizeClass

    let title: String

    let imageUrl: URL?

    @Binding var animate: Bool

    var backButtonAction: VoidAction?

    @State private var backButtonSize: CGRect = .zero

    private var layout: AnyLayout {
        animate // || sizeClass == .regular
        ? AnyLayout(HStackLayout())
        : AnyLayout(VStackLayout())
    }

    private var imageRadius: CGFloat { animate ? 50 : 100 }

    var body: some View {
        ZStack {
            coverPhotoView

            layout {

                HStack {
                    backButton
                    verticalSpacerView
                    avatarView
                        .offset(x: animate ? 0 : -10)
                    verticalSpacerView
                }
                titleView
                horizontalSpacerView
            }
            .padding(20)
            .animation(.spring(), value: animate)
        }
        .animation(.spring(), value: animate)
        .frame(maxWidth: .infinity)
        .frame(height: animate ? 80 : 160)
    }

    private var coverPhotoView: some View {
        PhotoView(imageUrl: imageUrl)
            .scaledToFill()
            .clipShape(Rectangle())
            .blur(radius: 20)
            .lighterOpacity()
    }

    private var avatarView: some View {
        PhotoView(imageUrl: imageUrl)
            .scaledToFill()
            .frame(width: imageRadius, height: imageRadius)
            .background(.gray)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(.white, lineWidth: animate ? 2 : 4)
            )
            .animation(.spring(), value: animate)
    }

    private var titleView: some View {
        Text(title)
            .font(.title)
            .foregroundStyle(AppStyle.white)
    }

    private var backButton: some View {
        BackButton(action: { backButtonAction?() })
    }

    @ViewBuilder
    private var horizontalSpacerView: some View {
        if animate {
            Spacer()
        }
    }

    @ViewBuilder
    private var verticalSpacerView: some View {
        if !animate {
            Spacer()
        }
    }
}

// MARK: Preview

struct ListHeader_Previews: PreviewProvider {

    static var previews: some View {
        Preview()
            .previewAsComponent()
    }

    struct Preview: View {
        @State var animate = false

        var body: some View {
            ListHeader(title: Category.mock.name,
                       imageUrl: Category.mock.imageUrl,
                       animate: $animate)
            .onTapGesture {
                animate.toggle()
            }
        }
    }
}
