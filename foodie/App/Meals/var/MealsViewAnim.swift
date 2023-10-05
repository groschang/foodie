//
//  MealsView.swift
//  foodie
//
//  Created by Konrad Groschang on 15/01/2023.
//

import SwiftUI

struct MealsViewAnim<Model>: View where Model: MealsViewModelType {

    private enum CoordinateSpace: String, CustomStringConvertible {
        case main
        case image
        case text

        var description: String {
            rawValue
        }
    }

    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var viewModel: Model

    @State private var offset: CGPoint = .zero
    @State private var contentSize: CGRect = .zero
    @State private var imageSize: CGRect = .zero
    @State private var textSize: CGRect = .zero

    private var offsetFactor: CGFloat { rangeFactor(value: offset.y, min: 0, max: 100) }
    private var headerHeight: CGFloat { value(start: 160, stop: 80, factor: -offsetFactor) }

    private var headerPadding: CGFloat { 8 }
    private var headerSpacing: CGFloat { 8 }
    private var imagePosition: CGFloat { -contentSize.width / 2.0 + imageWidth / 2.0 + headerPadding }

    private var imageWidth: CGFloat { value(start: 100, stop: 50, factor: -offsetFactor) }
//    private var imageScale: CGFloat { value(start: 1, stop: 0.5, factor: -offsetFactor) }
    private var imageXOffset: CGFloat { value(start: 0, stop: imagePosition, factor: -offsetFactor) }
    private var imageYOffset: CGFloat { value(start: -20, stop: 0, factor: -offsetFactor) }


    private var maxTextWidth: CGFloat { contentSize.width - headerSpacing }
    private var minTextWidth: CGFloat { maxTextWidth - imageWidth - headerPadding * 2 }
    private var textWidth: CGFloat { value(start: maxTextWidth, stop: minTextWidth, factor: -offsetFactor) }

    private var textXMaxOffset: CGFloat { imageWidth / 2.0 + headerSpacing }
    private var textXOffset: CGFloat { value(start: 0, stop: textXMaxOffset, factor: -offsetFactor) }

    private var textYOffset: CGFloat { value(start: contentSize.height - textSize.height,
                                             stop: 0, factor: -offsetFactor) }

    private var viewFactory: MealsViewFactory
    
    init(viewModel: Model, viewFactory: MealsViewFactory) {
        self.viewModel = viewModel
        self.viewFactory = viewFactory
        
        Task {  await viewModel.load() }
    }
    
    var body: some View {
        AsyncContentView(source: viewModel, content: content)
        //            .navigationTitle(viewModel.categoryName)
//            .navigationDestination(for: MealCategory.self) { meal in
//                viewFactory.makeMealView(selection: meal)
//            }
        //            .searchable(text: $viewModel.searchQuery)
            .refreshable {
                await viewModel.load()
            }
            .readingGeometry(from: CoordinateSpace.main.description, into: $contentSize)
    }
    
    private var content: some View {
        VStack {
            headerView
            recipes
        }
    }

    private var headerView: some View {
        ZStack {

            PhotoView(imageUrl: viewModel.backgroundUrl)
                .scaledToFill()
                .clipped()
                .blur(radius: 20)
                .lightOpacity()
                .offset(.init(width: 0, height: 80))

            ZStack {
                PhotoView(imageUrl: viewModel.backgroundUrl)
                    .modifier(ListPhotoStyle())
                    .frame(width: imageWidth, height: imageWidth)
                    .background(.gray)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(.white, lineWidth: 4)
                    )
//                    .scaleEffect(imageScale)
                    .offset(x: imageXOffset, y: imageYOffset)
                    .readingGeometry(from: CoordinateSpace.image.description, into: $imageSize)
                    .readingGeometry(from: CoordinateSpace.main.description, into: $contentSize)



                Text("\(viewModel.categoryName) \(offset.y, specifier: "%.0f") \(offsetFactor, specifier: "%.0f") \(textSize.height, specifier: "%.0f") \(contentSize.height, specifier: "%.0f") sdf dsfdsfsf sdf  fs f")
                    .frame(width: textWidth)
                    .font(.title)
                    .foregroundColor(.white)
                    .background(.red.opacity(0.4))
                    .offset(x: textXOffset, y: textYOffset)
                    .readingGeometry(from: CoordinateSpace.text.description, into: $textSize)

            }
            .offset(y: 60)


        }
        .coordinateSpace(name: CoordinateSpace.image.description)
        .coordinateSpace(name: CoordinateSpace.text.description)
        .frame(maxWidth: .infinity)
        .frame(height: headerHeight)
        .edgesIgnoringSafeArea(.top)
    }

    private var recipes: some View {
        ScrollView {
            Section(content: { meals }, header: { header } )
        }
        .coordinateSpace(name: CoordinateSpace.main.description)
        .modifier(ListModifier())
        .background(ColorStyle.background)
    }
    
    private var description: some View { //TODO: remove?
        DisclosureGroup("Description") {
            Text(viewModel.description)
        }
        .modifier(MealsViewAnimDescriptionStyle())
    }

    private var header: some View {
        HStack {
            Text("\(viewModel.itemsCount) RECIPES")
                .font(.footnote)

            Spacer()

            Button(
                action: { },
                label: {
                    Text("Filter")
                        .font(.footnote)
                }
            )
        }
        .padding()
        .readScrollView(from: CoordinateSpace.main.rawValue, into: $offset)
    }
    
    private var meals: some View {
        ForEach(viewModel.filteredItems) { meal in
            RouterLink(to: .meal(meal)) {
                MealListView(meal: meal)
            }
        }
        .modifier(ListRowModifier())
    }
}

// MARK: Previews

struct MealsViewAnim_Previews: PreviewProvider {
    static var previews: some View {
        MealsView(viewModel: MealsViewModelMock())
            .previewAsScreen()
    }
}

// MARK: Styles

struct MealsViewAnimDescriptionStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minHeight: 50)
            .modifier(ListStyle())
            .listRowInsets(ListStyle.textInserts)
    }
}


private extension MealsViewAnim {

    func rangeFactor(value: CGFloat, min: CGFloat, max: CGFloat) -> CGFloat {
        if value - min < 0 {
            return 0
        } else if value - max > 0 {
            return 1
        } else {
            return (value - min) / max
        }
    }

    func value(min: CGFloat, max: CGFloat, factor: CGFloat) -> CGFloat {
        let offset = (max - min) * factor
        let value = min + offset
        return value
    }

    func value(start: CGFloat, stop: CGFloat, factor: CGFloat) -> CGFloat {
        let offset = (start - stop) * factor
        let value = start + offset
        return value
    }

}
