//
//  foodieWidgetBundle.swift
//  foodieWidget
//
//  Created by Konrad Groschang on 01/07/2023.
//

import WidgetKit
import SwiftUI

@main
struct foodieWidgetBundle: WidgetBundle {

    var body: some Widget {
        FoodieWidget()

#if canImport(ActivityKit)
        foodieWidgetLiveActivity()
#endif

    }

}
